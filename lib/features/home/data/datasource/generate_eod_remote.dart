import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/endpoints.dart';

import '../../../../core/data/model.dart';
import 'package:http/http.dart' as http;

abstract class GenerateEodRemote {
  Future<ResponseModel> generateEodAPI();
}

class GenerateEodRemoteImpl implements GenerateEodRemote {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  @override
  Future<ResponseModel> generateEodAPI() async {
    String? token = await secureStorage.read(key: 'userToken');
    var res = await http.post(
      Uri.parse(generateEodEndpoint),
      headers: headerFile(token!),
    );
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
