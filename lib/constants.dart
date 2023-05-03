import 'package:flutter/material.dart';
import 'package:hebron_pay/size_config.dart';
import 'package:pinput/pinput.dart';

/// Colors
const kBackgroundColor = Color(0xFFFFFFFF);
const kPrimaryColor = Color(0xFF3C0945);
const kBlackColor = Color(0xFF000000);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightGrey = Color(0xFFC4C4C4);
const kLightPurple = Color(0xFF6A5C6C);
const kTransparentPurple = Color(0x3C094566);
const kTransparentBlack = Color(0x81000000);
const kErrorColor = Color(0xFF610606);

/// Assets - Images
String onboardingOne = "assets/images/onboarding1.png";
String onboardingTwo = "assets/images/onboarding2.png";
String onboardingThree = "assets/images/onboarding3.png";

/// Assets - Icons
String backArrow = "assets/images/icons/backArrow.svg";
String eye = "assets/images/icons/eye.svg";
String eyeSlash = "assets/images/icons/eyeSlash.svg";
String logOut = "assets/images/icons/logOut.svg";

/// PinThemes for OTP
PinTheme kDefaultPin(BuildContext context) {
  return PinTheme(
      width: getProportionateScreenWidth(55),
      height: getProportionateScreenHeight(60),
      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: kBlackColor, fontSize: 20, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kPrimaryColor)));
}

PinTheme kFocusedPin(BuildContext context) {
  return PinTheme(
      width: getProportionateScreenWidth(55),
      height: getProportionateScreenHeight(60),
      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: kPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kPrimaryColor, width: 3)));
}
