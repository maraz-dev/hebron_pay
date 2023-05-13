// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/features/profile/presentation/pages/profile.dart';
import 'package:hebron_pay/size_config.dart';
import 'package:pinput/pinput.dart';

class ChangePinScreen extends StatefulWidget {
  const ChangePinScreen({super.key});
  static const id = '/changePin';

  @override
  State<ChangePinScreen> createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  @override
  void initState() {
    super.initState();

    /// Build the Transaction PIN bottomsheet when the change pin button is clicked
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showModalBottomSheet(context);
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
          'Change Password',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Form(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),

                /// Enter the PIN the First Time
                Text(
                  'Enter your New 4-digit PIN',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, color: kDarkGrey),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Pinput(
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, color: kDarkGrey),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Pinput(
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
                  text: 'Change Pin',
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Transaction PIN Modal Sheet
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.popUntil(
                  context, ModalRoute.withName('/profileScreen'));
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
              child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                SizedBox(height: getProportionateScreenHeight(40)),

                /// Transaction PIN Box
                Center(
                  child: Pinput(
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
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                GeneralButton(
                    text: 'Continue',
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                SizedBox(height: getProportionateScreenHeight(20))
              ]),
            ),
          );
        });
  }
}
