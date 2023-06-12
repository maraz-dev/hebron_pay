import 'dart:convert';

import '../../domain/entities/create_account_entity.dart';

CreateAccountResponseModel createAccountResponseModelFromJson(String str) =>
    CreateAccountResponseModel.fromJson(json.decode(str));

String createAccountResponseModelToJson(CreateAccountResponseModel data) =>
    json.encode(data.toJson());

class CreateAccountResponseModel extends CreateAccountEntity {
  // final String firstName;
  // final String lastName;
  // final String gender;
  // final String dateofBirth;
  // final bool isOtpVerified;
  // final bool isKycVerified;
  // final int subAccountId;
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

  const CreateAccountResponseModel({
    required super.firstName,
    required super.lastName,
    required super.gender,
    required super.dateofBirth,
    required super.isOtpVerified,
    required super.isKycVerified,
    required super.subAccountId,
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

  factory CreateAccountResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateAccountResponseModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        dateofBirth: json["dateofBirth"],
        isOtpVerified: json["isOtpVerified"],
        isKycVerified: json["isKycVerified"],
        subAccountId: json["subAccountId"],
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
        "dateofBirth": dateofBirth,
        "isOtpVerified": isOtpVerified,
        "isKycVerified": isKycVerified,
        "subAccountId": subAccountId,
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
