import 'package:flutter/material.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/general_button.dart';
import 'package:hebron_pay/size_config.dart';
import 'package:pinput/pinput.dart';

/// Transaction PIN Modal Sheet
void showPinBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.popUntil(context, ModalRoute.withName('/profileScreen'));
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
