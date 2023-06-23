import 'dart:convert';

import 'package:hebron_pay/features/home/domain/entity/account_details_entity.dart';

AccountDetailsModel accountDetailsModelFromJson(String str) =>
    AccountDetailsModel.fromJson(json.decode(str));

String accountDetailsModelToJson(AccountDetailsModel data) =>
    json.encode(data.toJson());

class AccountDetailsModel extends AccountDetailsEntity {
  // final String accountNumber;
  // final String accountName;

  const AccountDetailsModel({
    required super.accountNumber,
    required super.accountName,
  });

  factory AccountDetailsModel.fromJson(Map<String, dynamic> json) =>
      AccountDetailsModel(
        accountNumber: json["account_number"],
        accountName: json["account_name"],
      );

  Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "account_name": accountName,
      };
}
