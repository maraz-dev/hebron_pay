// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/features/dashboard/presentation/pages/dashboard.dart';
import 'package:hebron_pay/features/profile/presentation/bloc/change_pin_cubit/change_pin_cubit.dart';
import 'package:hebron_pay/size_config.dart';
import 'package:pinput/pinput.dart';

class ChangePinScreen extends StatefulWidget {
  const ChangePinScreen({super.key});
  static const id = '/changePin';

  @override
  State<ChangePinScreen> createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  /// A [TextEditingController] variable to hold the amount to be Withdrawn
  final TextEditingController _pinController = TextEditingController();

  /// A [TextEditingController] variable to hold the amount to be Withdrawn
  final TextEditingController _newPinController = TextEditingController();

  /// A [TextEditingController] variable to hold the amount to be Withdrawn
  final TextEditingController _reenteredPinController = TextEditingController();

  /// [GlobalKey] to Validate the Sign In form
  final GlobalKey<FormState> _pinFormKey = GlobalKey();
  bool _isLoading = false;

  bool _proceedToWithdraw = false;
  @override
  void initState() {
    super.initState();

    /// Build the Transaction PIN bottomsheet when the change pin button is clicked
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPinBottomSheet(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            backArrowIcon,
            color: kPrimaryColor,
          ),
        ),
        title: Text(
          'Change PIN',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocConsumer<ChangePinCubit, ChangePinState>(
        listener: (context, state) {
          if (state is ChangePinSuccess) {
            const message = "PIN Successfully Changed";
            showSuccessSnackBar(context, message);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DashBoard(
                currentIndex: 0,
              );
            }));
          }
          if (state is ChangePinFailure) {
            final exception = (state).errorMessage;
            showErrorSnackBar(context, exception);
          }
        },
        builder: (context, state) {
          if (state is ChangePinLoading) {
            _isLoading = true;
          } else {
            _isLoading = false;
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Form(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),

                    /// Enter the PIN the First Time
                    Text(
                      'Enter your New 4-digit PIN',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: kDarkGrey),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Pinput(
                      controller: _newPinController,
                      onCompleted: (value) {
                        setState(() {
                          //_otpController.text = value;
                          //print(_otpController.text);
                        });
                      },
                      length: 4,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      defaultPinTheme: kDefaultPin(context),
                      focusedPinTheme: kFocusedPin(context),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),

                    /// Enter the PIN the Second Time
                    Text(
                      'CONFIRM your New 4-digit PIN',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: kDarkGrey),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Pinput(
                      controller: _reenteredPinController,
                      onCompleted: (value) {
                        setState(() {
                          //_otpController.text = value;
                          //print(_otpController.text);
                        });
                      },
                      length: 4,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      defaultPinTheme: kDefaultPin(context),
                      focusedPinTheme: kFocusedPin(context),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),

                    /// Change PIN Button
                    GeneralButton(
                      isLoading: _isLoading,
                      text: 'Change Pin',
                      onPressed: _submitChangePin,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitChangePin() async {
    FocusScope.of(context).unfocus();
    await BlocProvider.of<ChangePinCubit>(context).changePassword(
      {
        "currentPin": int.tryParse(_pinController.text),
        "newWalletPin": int.tryParse(_newPinController.text),
        "confirmNewWalletPin": int.tryParse(_reenteredPinController.text),
      },
    );
  }

  /// Transaction PIN Modal Sheet
  void _showPinBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return DashBoard(
                  currentIndex: 2,
                );
              }), (route) => false);
              return false;
            },
            child: Container(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(20),
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20),
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: kWhiteColor,
              ),
              child: Form(
                key: _pinFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        'Enter PIN',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    Text(
                      'Enter your Transaction PIN below to continue',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: getProportionateScreenHeight(20)),

                    /// Transaction PIN Box
                    Center(
                      child: Pinput(
                        controller: _pinController,
                        length: 4,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        defaultPinTheme: kDefaultPin(context),
                        focusedPinTheme: kFocusedPin(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field Cannot be Empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    GeneralButton(
                        isLoading: _isLoading,
                        text: 'Continue',
                        onPressed: () async {
                          FlutterSecureStorage secureStorage =
                              const FlutterSecureStorage();
                          String? userPin =
                              await secureStorage.read(key: 'userPin');
                          if (!_pinFormKey.currentState!.validate()) return;

                          if (int.parse(userPin!) ==
                              int.parse(_pinController.text)) {
                            setState(() {
                              _proceedToWithdraw = true;
                            });
                            Navigator.pop(context);
                            _pinController.clear();
                          } else {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return DashBoard(
                                currentIndex: 2,
                              );
                            }), (route) => false);
                            showErrorSnackBar(context, 'Incorrect Pin');
                            setState(() {
                              _proceedToWithdraw = false;
                            });
                            _pinController.clear();
                          }
                        }),
                    SizedBox(height: getProportionateScreenHeight(20))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
