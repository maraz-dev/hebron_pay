// ignore_for_file: unused_import

import 'dart:convert';

import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:hebron_pay/features/authentication/data/models/login_response_model.dart';
import 'package:http/http.dart' as http;

abstract class LoginRemoteDataSource {
  Future<ResponseModel> login(Map<String, dynamic> mapBody);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<ResponseModel> login(Map<String, dynamic> mapBody) async {
    dynamic res = await http.post(
      Uri.parse(loginEndpoint),
      body: jsonEncode(mapBody),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'text/plain',
        'Authorization': 'Basic MTExNzMxODg6NjAtZGF5ZnJlZXRyaWFs'
      },
    );
    print(res.body);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
