import 'dart:convert';

import 'package:hebron_pay/features/home/domain/entity/balance_entity.dart';

BalanceModel balanceModelFromJson(String str) =>
    BalanceModel.fromJson(json.decode(str));

String balanceModelToJson(BalanceModel data) => json.encode(data.toJson());

class BalanceModel extends BalanceEntity {
  // final String currency;
  // final String availableBalance;
  // final String ledgerBalance;

  const BalanceModel({
    required super.currency,
    required super.availableBalance,
    required super.ledgerBalance,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
        currency: json["currency"],
        availableBalance: json["available_balance"],
        ledgerBalance: json["ledger_balance"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "available_balance": availableBalance,
        "ledger_balance": ledgerBalance,
      };
}
