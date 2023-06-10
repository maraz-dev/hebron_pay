import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/authentication/data/datasources/login_remote.dart';
import 'package:hebron_pay/features/authentication/data/repositories/login_repo_impl.dart';
import 'package:hebron_pay/features/authentication/domain/repositories/login_repo.dart';
import 'package:hebron_pay/features/authentication/domain/usecases/login_usecase.dart';
import 'package:hebron_pay/features/authentication/presentation/cubit/login_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Bloc
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(loginUsecase: sl.call()),
  );

  ///Usecases
  sl.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(repository: sl.call()));

  ///Repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepoImpl(
      dataSource: sl.call(), secureStorage: sl.call(), networkInfo: sl.call()));

  ///Datasources
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl());

  ///Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  ///External
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
