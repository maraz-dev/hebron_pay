import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/authentication/data/datasources/create_account_remote.dart';
import 'package:hebron_pay/features/authentication/data/datasources/email_verification_remote.dart';
import 'package:hebron_pay/features/authentication/data/datasources/login_remote.dart';
import 'package:hebron_pay/features/authentication/data/repositories/create_account_repo_impl.dart';
import 'package:hebron_pay/features/authentication/data/repositories/email_verification_repo_impl.dart';
import 'package:hebron_pay/features/authentication/data/repositories/login_repo_impl.dart';
import 'package:hebron_pay/features/authentication/domain/repositories/create_account_repo.dart';
import 'package:hebron_pay/features/authentication/domain/repositories/login_repo.dart';
import 'package:hebron_pay/features/authentication/domain/repositories/otp_verification_repo.dart';
import 'package:hebron_pay/features/authentication/domain/usecases/create_account_usecase.dart';
import 'package:hebron_pay/features/authentication/domain/usecases/login_usecase.dart';
import 'package:hebron_pay/features/authentication/domain/usecases/otp_verification_usecase.dart';
import 'package:hebron_pay/features/authentication/presentation/bloc/email_verification_cubit/email_verification_cubit.dart';
import 'package:hebron_pay/features/authentication/presentation/bloc/sign_in_cubit/sign_up_cubit_cubit.dart';
import 'package:hebron_pay/features/home/data/datasource/balance_remote.dart';
import 'package:hebron_pay/features/home/data/datasource/fund_wallet_remote.dart';
import 'package:hebron_pay/features/home/data/datasource/generate_eod_remote.dart';
import 'package:hebron_pay/features/home/data/datasource/generate_ticket_remote.dart';
import 'package:hebron_pay/features/home/data/repository/balance_repo_impl.dart';
import 'package:hebron_pay/features/home/data/repository/fund_wallet_repo_impl.dart';
import 'package:hebron_pay/features/home/data/repository/generate_eod_repo_impl.dart';
import 'package:hebron_pay/features/home/data/repository/generate_ticket_repo_impl.dart';
import 'package:hebron_pay/features/home/domain/repository/balance_repo.dart';
import 'package:hebron_pay/features/home/domain/repository/fund_wallet_repo.dart';
import 'package:hebron_pay/features/home/domain/repository/generate_eod_repo.dart';
import 'package:hebron_pay/features/home/domain/repository/generate_ticket_repo.dart';
import 'package:hebron_pay/features/home/domain/usecase/balance_usecase.dart';
import 'package:hebron_pay/features/home/domain/usecase/fund_wallet_usecase.dart';
import 'package:hebron_pay/features/home/domain/usecase/generate_eod_usecase.dart';
import 'package:hebron_pay/features/home/domain/usecase/generate_ticket_usecase.dart';
import 'package:hebron_pay/features/home/presentation/bloc/balance_cubit/balance_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/fund_wallet_cubit/fund_wallet_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/generate_eod_cubit/generate_eod_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/generate_ticket_cubit/generate_ticket_cubit.dart';
import 'package:hebron_pay/features/profile/data/datasources/change_password_remote.dart';
import 'package:hebron_pay/features/profile/data/repositories/change_password_repo_impl.dart';
import 'package:hebron_pay/features/profile/domain/repositories/change_password_repo.dart';
import 'package:hebron_pay/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:hebron_pay/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/authentication/presentation/bloc/login_cubit/login_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Bloc
  sl.registerFactory<LoginCubit>(() => LoginCubit(loginUsecase: sl.call()));
  sl.registerFactory<SignUpCubit>(
      () => SignUpCubit(createAccountUsecase: sl.call()));
  sl.registerFactory<ProfileCubit>(
      () => ProfileCubit(changePasswordUsecase: sl.call()));
  sl.registerFactory<EmailVerificationCubit>(() => EmailVerificationCubit(
      sendOTPUsecase: sl.call(), validateOTPUsecase: sl.call()));
  sl.registerFactory<FundWalletCubit>(
      () => FundWalletCubit(fundWalletUsecase: sl.call()));
  sl.registerFactory<BalanceCubit>(
      () => BalanceCubit(balanceUsecase: sl.call()));
  sl.registerFactory<GenerateTicketCubit>(
      () => GenerateTicketCubit(usecase: sl.call()));
  sl.registerFactory<GenerateEodCubit>(
      () => GenerateEodCubit(usecase: sl.call()));

  ///Usecases
  sl.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(repository: sl.call()));
  sl.registerLazySingleton<BalanceUsecase>(
      () => BalanceUsecase(balanceRepository: sl.call()));
  sl.registerLazySingleton<CreateAccountUsecase>(
      () => CreateAccountUsecase(createAccountRepo: sl.call()));
  sl.registerLazySingleton<ChangePasswordUsecase>(
      () => ChangePasswordUsecase(repository: sl.call()));
  sl.registerLazySingleton<SendOTPUsecase>(
      () => SendOTPUsecase(repo: sl.call()));
  sl.registerLazySingleton<ValidateOTPUsecase>(
      () => ValidateOTPUsecase(repo: sl.call()));
  sl.registerLazySingleton<FundWalletUsecase>(
      () => FundWalletUsecase(fundWalletRepo: sl.call()));
  sl.registerLazySingleton<GenerateTicketUsecase>(
      () => GenerateTicketUsecase(generateTicketRepo: sl.call()));
  sl.registerLazySingleton<GenerateEodUsecase>(
      () => GenerateEodUsecase(repository: sl.call()));

  ///Repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepoImpl(
      dataSource: sl.call(), secureStorage: sl.call(), networkInfo: sl.call()));
  sl.registerLazySingleton<BalanceRepo>(
      () => BalanceRepoImpl(remoteDatasource: sl.call()));
  sl.registerLazySingleton<CreateAccountRepo>(() =>
      CreateAccountRepoImpl(networkInfo: sl.call(), dataSource: sl.call()));
  sl.registerLazySingleton<ChangePasswordRepo>(() => ChangePasswordRepoImpl(
      remoteDatasource: sl.call(), networkInfo: sl.call()));
  sl.registerLazySingleton<OtpVerificationRepo>(() => OtpVerificationRepoImpl(
      emailVerificationRemote: sl.call(), networkInfo: sl.call()));
  sl.registerLazySingleton<FundWalletRepo>(
      () => FundWalletRepoImpl(networkInfo: sl.call(), remoteData: sl.call()));
  sl.registerLazySingleton<GenerateTicketRepo>(
      () => GenerateTicketRepoImpl(remote: sl.call(), networkInfo: sl.call()));
  sl.registerLazySingleton<GenerateEodRepository>(
      () => GenerateEodRepoImpl(remote: sl.call(), networkInfo: sl.call()));

  ///Datasources
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl());
  sl.registerLazySingleton<BalanceRemoteDatasource>(
      () => BalanceRemoteDataImpl());
  sl.registerLazySingleton<CreateAccountRemoteDataSource>(
      () => CreateAccountRemoteDataSourceImpl());
  sl.registerLazySingleton<ChangePasswordRemote>(
      () => ChangePasswordRemoteImpl());
  sl.registerLazySingleton<EmailVerificationRemote>(
      () => EmailVerificationRemoteImpl());
  sl.registerLazySingleton<FundWalletRemoteData>(
      () => FundWalletRemoteDataImpl());
  sl.registerLazySingleton<GenerateTicketRemote>(
      () => GenerateTicketRemoteImpl());
  sl.registerLazySingleton<GenerateEodRemote>(() => GenerateEodRemoteImpl());

  ///Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  ///External
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
