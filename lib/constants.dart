import 'package:flutter/material.dart';
import 'package:hebron_pay/size_config.dart';
import 'package:pinput/pinput.dart';
import 'package:intl/intl.dart';

/// Function to format the amount to a Currency with the Naira symbol
String nairaAmount(double amount) {
  var nairaFormat = NumberFormat.currency(locale: 'en-NG', symbol: '₦');
  var formattedAmount = nairaFormat.format(amount);
  return formattedAmount;
}

/// Colors
const kBackgroundColor = Color(0xFFFFFFFF);
const kPrimaryColor = Color(0xFF3C0945);
const kBlackColor = Color(0xFF000000);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightGrey = Color(0xFFC4C4C4);
const kDarkGrey = Color(0xFF4B4B4E);
const kLightPurple = Color(0xFF6A5C6C);
const kTransparentPurple = Color(0x3C094566);
const kTransparentBlack = Color(0x81000000);
const kGreenColor = Color(0xFF27983A);
const kErrorColor = Color(0xFF610606);
const kErrorColorTransparent = Color.fromARGB(151, 97, 6, 6);

/// Assets - Images
String onboardingOne = "assets/images/onboarding1.png";
String onboardingTwo = "assets/images/onboarding2.png";
String onboardingThree = "assets/images/onboarding3.png";
String profileAvatar = "assets/images/profileAvatar.png";
String scanImage = "assets/images/scanImage.png";
String successTransaction = "assets/images/succesTransaction.png";
String failedTransaction = "assets/images/failedTransaction.png";
String qrSampleImage = "assets/images/qrSample.png";
String qrSample = "assets/images/qrSample.png";

/// Assets - Icons
String backArrowIcon = "assets/images/icons/backArrow.svg";
String eyeIcon = "assets/images/icons/eye.svg";
String eyeSlashIcon = "assets/images/icons/eyeSlash.svg";
String logOutIcon = "assets/images/icons/logOut.svg";
String homeIcon = "assets/images/icons/homeIcon.svg";
String scanIcon = "assets/images/icons/scanIcon.svg";
String profileIcon = "assets/images/icons/profileIcon.svg";
String changePasswordIcon = "assets/images/icons/changePasswordIcon.svg";
String changePinIcon = "assets/images/icons/changePinIcon.svg";
String helpAndSupportIcon = "assets/images/icons/helpIcon.svg";
String termsAndConditionIcon = "assets/images/icons/termsIcon.svg";
String arrowRightIcon = "assets/images/icons/arrowRight.svg";
String privacyIcon = "assets/images/icons/privacyPolicyIcon.svg";
String notificationReadIcon = "assets/images/icons/notificationRead.svg";
String debitIcon = "assets/images/icons/debitIcon.svg";
String creditIcon = "assets/images/icons/creditIcon.svg";
String pendingIcon = "assets/images/icons/pendingIcon.svg";
String timeIcon = "assets/images/icons/timeIcon.svg";
String ticketIcon = "assets/images/icons/ticketIcon.svg";
String eodIcon = "assets/images/icons/eodIcon.svg";

/// PinThemes for default OTP
PinTheme kDefaultPin(BuildContext context) {
  return PinTheme(
      width: getProportionateScreenWidth(55),
      height: getProportionateScreenHeight(60),
      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: kBlackColor, fontSize: 20, fontWeight: FontWeight.w700),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kPrimaryColor)));
}

/// PinThemes for foucsed OTP
PinTheme kFocusedPin(BuildContext context) {
  return PinTheme(
      width: getProportionateScreenWidth(55),
      height: getProportionateScreenHeight(60),
      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: kPrimaryColor, fontSize: 20, fontWeight: FontWeight.w700),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kPrimaryColor, width: 3)));
}
