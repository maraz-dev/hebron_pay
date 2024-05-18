import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;

abstract class GetPendingTransactionRemote {
  Future<ResponseModel> getPendingTransactionAPI();
}

class GetPendingTransactionRemoteImpl implements GetPendingTransactionRemote {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<ResponseModel> getPendingTransactionAPI() async {
    String? token = await secureStorage.read(key: 'userToken');
    var res = await http.get(
      Uri.parse(getPendingTransactionEndpoint),
      headers: headerFile(token!),
    );
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
