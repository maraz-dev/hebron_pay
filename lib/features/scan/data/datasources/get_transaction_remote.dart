// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/data/get_token.dart';
import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;

abstract class GetScannedTransactionRemote {
  Future<ResponseModel> getTransactionApi(String reference);
}

class GetScannedTransactionRemoteImpl implements GetScannedTransactionRemote {
  @override
  Future<ResponseModel> getTransactionApi(String reference) async {
    var res = await http.get(
      Uri.parse('$getScannedTransactionEndpoint?reference=$reference'),
      headers: headerFile(await getToken()),
    );
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
