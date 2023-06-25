import 'dart:convert';

import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/data/get_token.dart';
import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;

abstract class ConfirmPaymentRemote {
  Future<ResponseModel> confirmPaymentApi(Map<String, dynamic> map);
}

class ConfirmPaymentRemoteImpl implements ConfirmPaymentRemote {
  @override
  Future<ResponseModel> confirmPaymentApi(Map<String, dynamic> map) async {
    var res = await http.post(
      Uri.parse(confirmPaymentEndpoint),
      body: json.encode(map),
      headers: headerFile(await getToken()),
    );
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
