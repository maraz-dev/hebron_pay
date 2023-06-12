// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/home/data/datasource/balance_remote.dart';
import 'package:hebron_pay/features/home/data/models/balance_model.dart';
import 'package:hebron_pay/features/home/domain/repository/balance_repo.dart';

class BalanceRepoImpl implements BalanceRepo {
  final BalanceRemoteDatasource remoteDatasource;
  final FlutterSecureStorage secureStorage;
  final NetworkInfo networkInfo;

  BalanceRepoImpl(
      {required this.remoteDatasource,
      required this.secureStorage,
      required this.networkInfo});
  @override
  Future<BalanceModel> getBalance() async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remoteDatasource.showBalance();
        if (response.message != 'success' && response.error != null) {
          print('Balance Error 1');
          throw (response.error['message']);
        } else {
          print(response.message);
          var userBalance = BalanceModel.fromJson(response.data);

          /// Save the Balance
          await secureStorage.write(
              key: 'userBalance', value: json.encode(userBalance.toJson()));

          ///Convert the Balance response to a Model
          userBalance = BalanceModel.fromJson(response.data);
          return userBalance;
        }
      } on Exception {
        print("Balance Error 2");
        rethrow;
      }
    } else {
      throw "You're not Connected to the Internet";
    }
  }
}
