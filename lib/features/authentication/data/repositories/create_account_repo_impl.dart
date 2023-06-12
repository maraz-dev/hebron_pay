// ignore_for_file: avoid_print

import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/authentication/data/datasources/create_account_remote.dart';

import '../../domain/repositories/create_account_repo.dart';

class CreateAccountRepoImpl implements CreateAccountRepo {
  final NetworkInfo networkInfo;
  final CreateAccountRemoteDataSource dataSource;

  CreateAccountRepoImpl({required this.networkInfo, required this.dataSource});
  @override
  Future<String> createAccount(Map<String, dynamic> mapBody) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await dataSource.createAccountDt(mapBody);
        if (response.message != 'success' && response.error != null) {
          print("Create Account Error 1");
          throw (response.error['message']);
        } else {
          return response.message;
        }
      } on Exception {
        print('Create Account Error 2');
        rethrow;
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }
}
