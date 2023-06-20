import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;

abstract class GetTransactionRemote {
  Future<ResponseModel> getTransactionAPI();
}

class GetTransactionRemoteImpl implements GetTransactionRemote {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<ResponseModel> getTransactionAPI() async {
    String? token = await secureStorage.read(key: 'userToken');
    var res = await http.get(Uri.parse(getTransactionEndpoint), headers: {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer ${token!}'
    });
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
