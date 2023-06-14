// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/core/domain/entity.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;

abstract class ChangePasswordRemote {
  Future<ResponseEntity> changePasswordremote(Map<String, dynamic> map);
}

class ChangePasswordRemoteImpl implements ChangePasswordRemote {
  @override
  Future<ResponseEntity> changePasswordremote(Map<String, dynamic> map) async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'userToken');
    var res = await http.post(
      Uri.parse(changePasswordEndpoint),
      body: json.encode(map),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'text/plain',
        'Authorization': 'Bearer ${token!}'
      },
    );
    print("Remote Code is ${res.statusCode}");
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
