import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;

abstract class GenerateTicketRemote {
  Future<ResponseModel> generateTicketAPI(Map<String, dynamic> mapBody);
}

class GenerateTicketRemoteImpl implements GenerateTicketRemote {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<ResponseModel> generateTicketAPI(Map<String, dynamic> mapBody) async {
    String? token = await secureStorage.read(key: 'userToken');
    var res = await http.post(Uri.parse(generateTicketEndpoint),
        body: json.encode(mapBody),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'text/plain',
          'Authorization': 'Bearer ${token!}'
        });
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
