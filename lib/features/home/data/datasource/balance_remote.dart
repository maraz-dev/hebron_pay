import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;

abstract class BalanceRemoteDatasource {
  Future<ResponseModel> showBalance();
}

class BalanceRemoteDataImpl implements BalanceRemoteDatasource {
  @override
  Future<ResponseModel> showBalance() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'userToken');
    dynamic res = await http.get(
      Uri.parse(getSubAccountBalanceEndpoint),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'text/plain',
        'Bearer Token': token!
      },
    );
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
