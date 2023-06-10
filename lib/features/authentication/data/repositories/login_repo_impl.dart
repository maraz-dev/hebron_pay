import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/authentication/data/datasources/login_remote.dart';
import 'package:hebron_pay/features/authentication/data/models/login_response_model.dart';
import 'package:hebron_pay/features/authentication/domain/repositories/login_repo.dart';

class LoginRepoImpl implements LoginRepository {
  final LoginRemoteDataSource dataSource;
  final FlutterSecureStorage secureStorage;
  final NetworkInfo networkInfo;

  LoginRepoImpl(this.dataSource, this.secureStorage, this.networkInfo);
  @override
  Future<LoginResponseModel> login(Map<String, dynamic> mapBody) async {
    if (await networkInfo.isConnected) {
      try {
        String email = mapBody['email'];
        String password = mapBody['password'];

        var res = await dataSource.login(
          {
            'email': email,
            'password': password,
          },
        );

        if (res.message != 'success' && res.error != null) {
          throw (res.error['message']);
        } else {
          print(res.message);
          //await secureStorage.write(key: 'token', value: res.data['token']);
          var userData = LoginResponseModel.fromJson(res.data);
          await secureStorage.write(
              key: 'userData', value: json.encode(userData.toJson()));

          return userData;
        }
      } on Exception catch (e) {
        throw (e);
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }
}
