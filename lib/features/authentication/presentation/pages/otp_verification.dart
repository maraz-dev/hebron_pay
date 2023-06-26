import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/features/authentication/presentation/bloc/email_verification_cubit/email_verification_cubit.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/login.dart';
import 'package:hebron_pay/size_config.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key, required this.emailAddress});
  static const id = '/otpVerification';

  /// Email Address passed from the Register Screen
  final String emailAddress;
  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  /// A [TextEditingController] for the OTP field
  final TextEditingController _otpController = TextEditingController();
  final CountdownController _timerController = CountdownController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    print(widget.emailAddress);
    BlocProvider.of<EmailVerificationCubit>(context)
        .sendOTP(widget.emailAddress);
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(backArrowIcon),
        ),
      ),
      body: const AuthenticationBackground(),
      bottomSheet: BlocConsumer<EmailVerificationCubit, EmailVerificationState>(
        listener: (context, state) {
          if (state is EmailVerificationSent) {
            showSuccessSnackBar(context, "OTP has been Sent");
            _timerController.restart();
          }
          if (state is EmailVerificationSuccess) {
            showSuccessSnackBar(context, "Your Email has been Verified");
            Navigator.pushNamed(context, LoginScreen.id);
          }
          if (state is EmailVerificationFailed) {
            showErrorSnackBar(context, (state).errorMessage);
          }
        },
        builder: (context, state) {
          if (state is EmailVerificationLoading) {
            _isLoading = true;
          } else {
            _isLoading = false;
          }
          return AuthenticationBody(
            body: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    'OTP Verification',
                    style: Theme.of(context).textTheme.displayMedium,
                  )),
                  Center(
                    child: Text(
                      "An OTP code has been sent to your email",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),

                  /// OTP Textfields
                  Center(
                    child: Pinput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "PIN cannot be empty";
                        }
                        return null;
                      },
                      onCompleted: (value) {
                        setState(() {
                          _otpController.text = value;
                          //print(_otpController.text);
                        });
                      },
                      length: 5,
                      textInputAction: TextInputAction.done,
                      defaultPinTheme: kDefaultPin(context),
                      focusedPinTheme: kFocusedPin(context),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(25)),

                  Countdown(
                      controller: _timerController,
                      seconds: 60,
                      interval: const Duration(milliseconds: 100),
                      build: (_, double time) {
                        return Text(
                          "00:${time.toStringAsFixed(0)}",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: kErrorColor),
                        );
                      }),

                  /// Resend OTP Button
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "I didn’t receive any code. ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: _resendOtp,
                          child: Text(
                            'Resend Code',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(50)),

                  /// General Button
                  GeneralButton(
                    isLoading: _isLoading,
                    text: 'Continue',
                    onPressed: _validateOtp,
                  )
                ],
              ),
            )),
          );
        },
      ),
    );
  }

  void _validateOtp() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    await BlocProvider.of<EmailVerificationCubit>(context)
        .validateOtp(widget.emailAddress, _otpController.text);
  }

  void _resendOtp() async {
    FocusScope.of(context).unfocus();
    await BlocProvider.of<EmailVerificationCubit>(context)
        .sendOTP(widget.emailAddress);
    _timerController.restart();
  }
}
