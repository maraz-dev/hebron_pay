import 'dart:convert';

import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/data/get_token.dart';
import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/endpoints.dart';
import 'package:http/http.dart' as http;

abstract class WithdrawRemote {
  Future<ResponseModel> getBanks();
  Future<ResponseModel> resolveAccountDetails(Map<String, dynamic> map);
  Future<ResponseModel> withdrawApi(Map<String, dynamic> map);
}

class WithdrawRemoteImpl implements WithdrawRemote {
  @override
  Future<ResponseModel> getBanks() async {
    var res = await http.get(Uri.parse(getBankEndpoint),
        headers: headerFile(await getToken()));
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }

  @override
  Future<ResponseModel> resolveAccountDetails(Map<String, dynamic> map) async {
    var res = await http.post(
      Uri.parse(resolveAccountDetailsEndpoint),
      body: json.encode(map),
      headers: headerFile(await getToken()),
    );
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }

  @override
  Future<ResponseModel> withdrawApi(Map<String, dynamic> map) async {
    var res = await http.post(
      Uri.parse(withdrawEndpoint),
      body: json.encode(map),
      headers: headerFile(await getToken()),
    );
    print(res.statusCode);
    return ResponseModel.fromJson(json.decode(res.body));
  }
}
