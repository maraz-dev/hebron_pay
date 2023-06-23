import 'dart:convert';

import 'package:hebron_pay/features/home/domain/entity/bank_entity.dart';

BankModel bankFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankToJson(BankModel data) => json.encode(data.toJson());

class BankModel extends BankEntity {
  // int id;
  // String code;
  // String name;

  const BankModel({
    required super.id,
    required super.code,
    required super.name,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        id: json["id"],
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
      };
}
