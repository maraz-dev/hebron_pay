import 'dart:convert';

import 'package:hebron_pay/features/home/domain/entity/balance_entity.dart';

HebronPayWallet hebronPayWalletFromJson(String str) =>
    HebronPayWallet.fromJson(json.decode(str));

String hebronPayWalletToJson(HebronPayWallet data) =>
    json.encode(data.toJson());

class HebronPayWallet extends BalanceEntity {
  // int id;
  // int walletBalance;
  // int walletPin;

  const HebronPayWallet({
    required super.id,
    required super.walletBalance,
    required super.walletPin,
  });

  factory HebronPayWallet.fromJson(Map<String, dynamic> json) =>
      HebronPayWallet(
        id: json["id"],
        walletBalance: json["walletBalance"],
        walletPin: json["walletPin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "walletBalance": walletBalance,
        "walletPin": walletPin,
      };
}
