import 'dart:convert';

import 'package:hebron_pay/features/scan/domain/entities/get_transaction_entity.dart';

GetTransactionModel getTransactionModelFromJson(String str) =>
    GetTransactionModel.fromJson(json.decode(str));

String getTransactionModelToJson(GetTransactionModel data) =>
    json.encode(data.toJson());

class GetTransactionModel extends GetTrxEntity {
  // final int id;
  // final String description;
  // final int amount;
  // final String reference;
  // final String type;
  // final String date;
  // final String time;
  // final String username;

  const GetTransactionModel({
    required super.id,
    required super.description,
    required super.amount,
    required super.reference,
    required super.type,
    required super.date,
    required super.time,
    required super.username,
  });

  factory GetTransactionModel.fromJson(Map<String, dynamic> json) =>
      GetTransactionModel(
        id: json["id"],
        description: json["description"],
        amount: json["amount"],
        reference: json["reference"],
        type: json["type"],
        date: json["date"],
        time: json["time"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "amount": amount,
        "reference": reference,
        "type": type,
        "date": date,
        "time": time,
        "username": username,
      };
}
