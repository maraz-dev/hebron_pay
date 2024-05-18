// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/core/domain/entity.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;

abstract class EmailVerificationRemote {
  Future<ResponseEntity> sendOTP(String email);
  Future<ResponseEntity> validateOTP(String email, String inputPin);
}

class EmailVerificationRemoteImpl implements EmailVerificationRemote {
  @override
  Future<ResponseModel> sendOTP(String email) async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'userToken');
    var res = await http.post(
      Uri.parse("$sendOTPEndpoint?email=$email"),
      headers: headerFile(token),
    );

    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }

  @override
  Future<ResponseModel> validateOTP(String email, String inputPin) async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'userToken');
    var res = await http.post(
      Uri.parse("$validateOTPEndpoint?email=$email&inputPin=$inputPin"),
      headers: headerFile(token),
    );

    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
