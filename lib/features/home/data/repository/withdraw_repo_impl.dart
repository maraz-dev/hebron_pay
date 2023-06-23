// ignore_for_file: avoid_print

import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/home/data/datasource/withdraw_remote.dart';
import 'package:hebron_pay/features/home/data/models/account_details_model.dart';
import 'package:hebron_pay/features/home/data/models/bank_model.dart';
import 'package:hebron_pay/features/home/domain/entity/account_details_entity.dart';
import 'package:hebron_pay/features/home/domain/entity/bank_entity.dart';
import 'package:hebron_pay/features/home/domain/repository/withdraw_repo.dart';

class WithdrawRepoImpl implements WithdrawRepo {
  final NetworkInfo networkInfo;
  final WithdrawRemote remote;

  WithdrawRepoImpl({required this.networkInfo, required this.remote});
  @override
  Future<List<BankEntity>> getBanks() async {
    List<BankEntity> allBanks = [];
    if (await networkInfo.isConnected) {
      try {
        var response = await remote.getBanks();
        if (response.message != 'success' && response.error != null) {
          print(response.error['message']);
          throw (response.error['message']);
        } else {
          var responseList = response.data as List;
          allBanks = responseList
              .map<BankEntity>((response) => BankModel.fromJson(response))
              .toList();
          return allBanks;
        }
      } on Exception {
        rethrow;
      }
    } else {
      throw "You're not connecte to the Internet";
    }
  }

  @override
  Future<AccountDetailsEntity> resolveAccountDetails(
      Map<String, dynamic> mapBody) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remote.resolveAccountDetails(mapBody);
        if (response.message != 'success' && response.error != null) {
          print(response.error['message']);
          throw (response.error['message']);
        } else {
          return AccountDetailsModel.fromJson(response.data);
        }
      } on Exception {
        rethrow;
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }

  @override
  Future<String> withdraw(Map<String, dynamic> body) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remote.withdrawApi(body);
        if (response.message != 'success' && response.error != null) {
          print(response.error['message']);
          throw (response.error['message']);
        } else {
          return response.data;
        }
      } on Exception {
        rethrow;
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }
}
