// ignore_for_file: avoid_print

import 'dart:convert';

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
    var res = await http.post(
      Uri.parse("$sendOTPEndpoint?email=$email"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'text/plain',
      },
    );

    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }

  @override
  Future<ResponseModel> validateOTP(String email, String inputPin) async {
    var res = await http.post(
      Uri.parse("$validateOTPEndpoint?email=$email&inputPin=$inputPin"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'text/plain',
      },
    );

    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
