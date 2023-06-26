import 'dart:convert';

import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/data/get_token.dart';
import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/core/domain/entity.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;

abstract class ChangePinRemote {
  Future<ResponseEntity> changePinApi(Map<String, dynamic> body);
}

class ChangePinRemoteImpl implements ChangePinRemote {
  @override
  Future<ResponseEntity> changePinApi(Map<String, dynamic> body) async {
    var res = await http.post(
      Uri.parse(changePinEndpoint),
      body: json.encode(body),
      headers: headerFile(await getToken()),
    );
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
