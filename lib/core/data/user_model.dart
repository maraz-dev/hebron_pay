import 'dart:convert';

import 'package:hebron_pay/core/domain/user_entity.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends UserEntity {
  // final String firstName;
  // final String lastName;
  // final String gender;
  // final DateTime dateofBirth;
  // final bool isOtpVerified;
  // final bool isKycVerified;
  // final bool isPinSet;
  // final int subAccountId;
  // final SubAccount subAccount;
  // final int hebronPayWalletId;
  // final HebronPayWallet hebronPayWallet;
  // final String id;
  // final String userName;
  // final String normalizedUserName;
  // final String email;
  // final String normalizedEmail;
  // final bool emailConfirmed;
  // final String passwordHash;
  // final String securityStamp;
  // final String concurrencyStamp;
  // final String phoneNumber;
  // final bool phoneNumberConfirmed;
  // final bool twoFactorEnabled;
  // final dynamic lockoutEnd;
  // final bool lockoutEnabled;
  // final int accessFailedCount;

  const UserModel({
    required super.firstName,
    required super.lastName,
    required super.gender,
    required super.dateofBirth,
    required super.isOtpVerified,
    required super.isKycVerified,
    required super.isPinSet,
    required super.subAccountId,
    required super.subAccount,
    required super.hebronPayWalletId,
    required super.hebronPayWallet,
    required super.id,
    required super.userName,
    required super.normalizedUserName,
    required super.email,
    required super.normalizedEmail,
    required super.emailConfirmed,
    required super.passwordHash,
    required super.securityStamp,
    required super.concurrencyStamp,
    required super.phoneNumber,
    required super.phoneNumberConfirmed,
    required super.twoFactorEnabled,
    super.lockoutEnd,
    required super.lockoutEnabled,
    required super.accessFailedCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        dateofBirth: DateTime.parse(json["dateofBirth"]),
        isOtpVerified: json["isOtpVerified"],
        isKycVerified: json["isKycVerified"],
        isPinSet: json["isPinSet"],
        subAccountId: json["subAccountId"],
        subAccount: SubAccount.fromJson(json["subAccount"]),
        hebronPayWalletId: json["hebronPayWalletId"],
        hebronPayWallet: HebronPayWallet.fromJson(json["hebronPayWallet"]),
        id: json["id"],
        userName: json["userName"],
        normalizedUserName: json["normalizedUserName"],
        email: json["email"],
        normalizedEmail: json["normalizedEmail"],
        emailConfirmed: json["emailConfirmed"],
        passwordHash: json["passwordHash"],
        securityStamp: json["securityStamp"],
        concurrencyStamp: json["concurrencyStamp"],
        phoneNumber: json["phoneNumber"],
        phoneNumberConfirmed: json["phoneNumberConfirmed"],
        twoFactorEnabled: json["twoFactorEnabled"],
        lockoutEnd: json["lockoutEnd"],
        lockoutEnabled: json["lockoutEnabled"],
        accessFailedCount: json["accessFailedCount"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "dateofBirth":
            "${dateofBirth.year.toString().padLeft(4, '0')}-${dateofBirth.month.toString().padLeft(2, '0')}-${dateofBirth.day.toString().padLeft(2, '0')}",
        "isOtpVerified": isOtpVerified,
        "isKycVerified": isKycVerified,
        "isPinSet": isPinSet,
        "subAccountId": subAccountId,
        "subAccount": subAccount.toJson(),
        "hebronPayWalletId": hebronPayWalletId,
        "hebronPayWallet": hebronPayWallet.toJson(),
        "id": id,
        "userName": userName,
        "normalizedUserName": normalizedUserName,
        "email": email,
        "normalizedEmail": normalizedEmail,
        "emailConfirmed": emailConfirmed,
        "passwordHash": passwordHash,
        "securityStamp": securityStamp,
        "concurrencyStamp": concurrencyStamp,
        "phoneNumber": phoneNumber,
        "phoneNumberConfirmed": phoneNumberConfirmed,
        "twoFactorEnabled": twoFactorEnabled,
        "lockoutEnd": lockoutEnd,
        "lockoutEnabled": lockoutEnabled,
        "accessFailedCount": accessFailedCount,
      };
}

class HebronPayWallet extends HebronPayWalletEntity {
  // final int id;
  // final int walletBalance;
  // final int walletPin;

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

class SubAccount extends SubAccountEntity {
  // final int id;
  // final int flutterwaveSubAccountId;
  // final String accountReference;
  // final String accountName;
  // final String barterId;
  // final String email;
  // final String mobilenumber;
  // final String country;
  // final String nuban;
  // final String bankName;
  // final String bankCode;
  // final String status;
  // final DateTime createdAt;

  const SubAccount({
    required super.id,
    required super.flutterwaveSubAccountId,
    required super.accountReference,
    required super.accountName,
    required super.barterId,
    required super.email,
    required super.mobilenumber,
    required super.country,
    required super.nuban,
    required super.bankName,
    required super.bankCode,
    required super.status,
    required super.createdAt,
  });

  factory SubAccount.fromJson(Map<String, dynamic> json) => SubAccount(
        id: json["id"],
        flutterwaveSubAccountId: json["flutterwaveSubAccountId"],
        accountReference: json["account_reference"],
        accountName: json["account_name"],
        barterId: json["barter_id"],
        email: json["email"],
        mobilenumber: json["mobilenumber"],
        country: json["country"],
        nuban: json["nuban"],
        bankName: json["bank_name"],
        bankCode: json["bank_code"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "flutterwaveSubAccountId": flutterwaveSubAccountId,
        "account_reference": accountReference,
        "account_name": accountName,
        "barter_id": barterId,
        "email": email,
        "mobilenumber": mobilenumber,
        "country": country,
        "nuban": nuban,
        "bank_name": bankName,
        "bank_code": bankCode,
        "status": status,
        "created_at": createdAt.toIso8601String(),
      };
}
