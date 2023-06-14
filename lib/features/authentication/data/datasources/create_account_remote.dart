// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;
import '../../../../core/data/model.dart';

abstract class CreateAccountRemoteDataSource {
  Future<ResponseModel> createAccountDt(Map<String, dynamic> map);
}

class CreateAccountRemoteDataSourceImpl
    implements CreateAccountRemoteDataSource {
  @override
  Future<ResponseModel> createAccountDt(Map<String, dynamic> map) async {
    dynamic res = await http.post(
      Uri.parse(signUpEndpoint),
      body: json.encode(map),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'text/plain',
      },
    );
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
