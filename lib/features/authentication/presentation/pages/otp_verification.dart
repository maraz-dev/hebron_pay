import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/size_config.dart';
import 'package:pinput/pinput.dart';

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

  @override
  void initState() {
    super.initState();
    debugPrint(widget.emailAddress);
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
      bottomSheet: AuthenticationBody(
        body: SingleChildScrollView(
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

            /// Timer
            Text(
              '00:00',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: kErrorColor),
            ),

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
                    onTap: null,
                    child: Text(
                      'Resend Code',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(50)),

            /// General Button
            GeneralButton(text: 'Continue', onPressed: () {})
          ],
        )),
      ),
    );
  }
}
