// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;

abstract class FundWalletRemoteData {
  Future<ResponseModel> fundWalletAPI(Map<String, dynamic> map);
}

class FundWalletRemoteDataImpl implements FundWalletRemoteData {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  @override
  Future<ResponseModel> fundWalletAPI(Map<String, dynamic> map) async {
    String? token = await secureStorage.read(key: 'userToken');
    var res = await http.post(
      Uri.parse(fundWalletEndpoint),
      body: json.encode(map),
      headers: headerFile(token!),
    );
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
