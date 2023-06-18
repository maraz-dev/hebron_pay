import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/features/home/data/models/balance_model.dart';

abstract class BalanceRemoteDatasource {
  Future<HebronPayWallet> showBalance();
}

class BalanceRemoteDataImpl implements BalanceRemoteDatasource {
  @override
  Future<HebronPayWallet> showBalance() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    String? res = await secureStorage.read(key: 'walletDetails');
    var responseBody = json.decode(res!);
    return HebronPayWallet.fromJson(responseBody);
  }
}
