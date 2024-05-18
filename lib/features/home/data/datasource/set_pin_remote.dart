import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;

abstract class SetPinRemote {
  Future<ResponseModel> setPinApi(Map<String, dynamic> mapBody);
}

class SetPinRemoteImpl implements SetPinRemote {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  @override
  Future<ResponseModel> setPinApi(Map<String, dynamic> mapBody) async {
    String? token = await secureStorage.read(key: 'userToken');

    var res = await http.post(
      Uri.parse(setPinEndpoint),
      body: json.encode(mapBody),
      headers: headerFile(token!),
    );
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
