import 'package:flutter/material.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/forgot_password.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/login.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/sign_up.dart';
import 'package:hebron_pay/features/dashboard/presentation/pages/dashboard.dart';
import 'package:hebron_pay/features/home/presentation/pages/pending_transaction_receipt.dart';
import 'package:hebron_pay/features/home/presentation/pages/transaction_receipt.dart';
import 'package:hebron_pay/features/onboarding/presentation/pages/onboarding.dart';
import 'package:hebron_pay/features/profile/presentation/pages/change_password.dart';
import 'package:hebron_pay/features/profile/presentation/pages/change_pin.dart';
import 'package:hebron_pay/features/profile/presentation/pages/help_and_support.dart';
import 'package:hebron_pay/features/profile/presentation/pages/privacy_policy.dart';
import 'package:hebron_pay/features/profile/presentation/pages/profile.dart';
import 'package:hebron_pay/features/profile/presentation/pages/terms_and_condition.dart';
import 'package:hebron_pay/theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main(List<String> args) {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  runApp(const HebronPay());
}

class HebronPay extends StatelessWidget {
  const HebronPay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData(),
        initialRoute: OnboardingScreen.id,
        routes: {
          OnboardingScreen.id: (context) => const OnboardingScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          SignUpScreen.id: (context) => const SignUpScreen(),
          ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),
          DashBoard.id: (context) => const DashBoard(),
          ProfileScreen.id: (context) => const ProfileScreen(),
          ChangePasswordScreen.id: (context) => const ChangePasswordScreen(),
          ChangePinScreen.id: (context) => const ChangePinScreen(),
          TermsAndConditionScreen.id: (context) =>
              const TermsAndConditionScreen(),
          PrivacyPolicyScreen.id: (context) => const PrivacyPolicyScreen(),
          HelpAndSupportScreen.id: (context) => const HelpAndSupportScreen(),
          PendingTransactionReceipt.id: (context) =>
              const PendingTransactionReceipt(),
          TransactionReceipt.id: (context) => const TransactionReceipt()
        });
  }
}
