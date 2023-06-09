import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/core/bloc/cubit/user_details_cubit.dart';
import 'package:hebron_pay/features/authentication/presentation/bloc/email_verification_cubit/email_verification_cubit.dart';
import 'package:hebron_pay/features/authentication/presentation/bloc/login_cubit/login_cubit.dart';
import 'package:hebron_pay/features/authentication/presentation/bloc/sign_in_cubit/sign_up_cubit_cubit.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/forgot_password.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/login.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/sign_up.dart';
import 'package:hebron_pay/features/home/presentation/bloc/balance_cubit/balance_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/bank_details_cubit/bank_details_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/delete_ticket_cubit/delete_ticket_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/fund_wallet_cubit/fund_wallet_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/generate_eod_cubit/generate_eod_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/generate_ticket_cubit/generate_ticket_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/get_bank_cubit/get_bank_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/get_pending_transactions_cubit/pending_transactions_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/set_pin_cubit/set_pin_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/transaction_cubit/transaction_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/withdraw_cubit.dart/withdraw_cubit.dart';
import 'package:hebron_pay/features/home/presentation/pages/deposit.dart';
import 'package:hebron_pay/features/home/presentation/pages/generate_ticket.dart';
import 'package:hebron_pay/features/home/presentation/pages/withdraw.dart';
import 'package:hebron_pay/features/onboarding/presentation/pages/onboarding.dart';
import 'package:hebron_pay/features/profile/presentation/bloc/change_password_cubit/profile_cubit.dart';
import 'package:hebron_pay/features/profile/presentation/bloc/change_pin_cubit/change_pin_cubit.dart';
import 'package:hebron_pay/features/profile/presentation/pages/change_password.dart';
import 'package:hebron_pay/features/profile/presentation/pages/change_pin.dart';
import 'package:hebron_pay/features/profile/presentation/pages/help_and_support.dart';
import 'package:hebron_pay/features/profile/presentation/pages/privacy_policy.dart';
import 'package:hebron_pay/features/profile/presentation/pages/terms_and_condition.dart';
import 'package:hebron_pay/features/scan/presentation/bloc/confirm_payment_cubit/confirm_payment_cubit.dart';
import 'package:hebron_pay/features/scan/presentation/bloc/get_scanned_trx_cubit/get_scanned_trx_cubit.dart';
import 'package:hebron_pay/theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'injection_container.dart' as di;

void main(List<String> args) async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  di.init();
  String? onboardingDone =
      await secureStorage.read(key: 'onboardingCompleted') ?? 'false';
  runApp(HebronPay(
    onboardingDone: onboardingDone,
  ));
}

class HebronPay extends StatelessWidget {
  const HebronPay({super.key, required this.onboardingDone});
  final String onboardingDone;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
        BlocProvider<ProfileCubit>(create: (_) => di.sl<ProfileCubit>()),
        BlocProvider<SignUpCubit>(create: (_) => di.sl<SignUpCubit>()),
        BlocProvider<EmailVerificationCubit>(
            create: (_) => di.sl<EmailVerificationCubit>()),
        BlocProvider<FundWalletCubit>(create: (_) => di.sl<FundWalletCubit>()),
        BlocProvider<BalanceCubit>(create: (_) => di.sl<BalanceCubit>()),
        BlocProvider<GenerateTicketCubit>(
            create: (_) => di.sl<GenerateTicketCubit>()),
        BlocProvider<GenerateEodCubit>(
            create: (_) => di.sl<GenerateEodCubit>()),
        BlocProvider<PendingTransactionsCubit>(
            create: (_) => di.sl<PendingTransactionsCubit>()),
        BlocProvider<TransactionCubit>(
            create: (_) => di.sl<TransactionCubit>()),
        BlocProvider(create: (_) => di.sl<SetPinCubit>()),
        BlocProvider(create: (_) => di.sl<GetBankCubit>()),
        BlocProvider(create: (_) => di.sl<BankDetailsCubit>()),
        BlocProvider(create: (_) => di.sl<WithdrawCubit>()),
        BlocProvider(create: (_) => di.sl<DeleteTicketCubit>()),
        BlocProvider(create: (_) => di.sl<GetScannedTrxCubit>()),
        BlocProvider(create: (_) => di.sl<ConfirmPaymentCubit>()),
        BlocProvider(create: (_) => di.sl<UserDetailsCubit>()),
        BlocProvider(create: (_) => di.sl<ChangePinCubit>())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData(),
          initialRoute:
              onboardingDone == 'true' ? LoginScreen.id : OnboardingScreen.id,
          routes: {
            OnboardingScreen.id: (context) => const OnboardingScreen(),
            LoginScreen.id: (context) => const LoginScreen(),
            SignUpScreen.id: (context) => const SignUpScreen(),
            ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),
            ChangePasswordScreen.id: (context) => const ChangePasswordScreen(),
            ChangePinScreen.id: (context) => const ChangePinScreen(),
            TermsAndConditionScreen.id: (context) =>
                const TermsAndConditionScreen(),
            PrivacyPolicyScreen.id: (context) => const PrivacyPolicyScreen(),
            HelpAndSupportScreen.id: (context) => const HelpAndSupportScreen(),
            GenerateTicket.id: (context) => const GenerateTicket(),
            DepositScreen.id: (context) => const DepositScreen(),
            WithdrawScreen.id: (context) => const WithdrawScreen(),
          }),
    );
  }
}
