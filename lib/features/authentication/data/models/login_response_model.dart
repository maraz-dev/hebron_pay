import 'package:hebron_pay/features/authentication/domain/entities/login_entity.dart';

class LoginResponseModel extends LoginEntity {
  // final String token;
  // final String tokenUser;
  // final DateTime expiration;
  // final String firstName;
  // final String lastName;
  // final String gender;
  // final String dateofBirth;
  // final bool isOtpVerified;
  // final bool isKycVerified;
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

  const LoginResponseModel({
    required super.token,
    required super.tokenUser,
    required super.expiration,
    required super.firstName,
    required super.lastName,
    required super.gender,
    required super.dateofBirth,
    required super.isOtpVerified,
    required super.isKycVerified,
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

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json["token"],
        tokenUser: json["tokenUser"],
        expiration: DateTime.parse(json["expiration"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        dateofBirth: json["dateofBirth"],
        isOtpVerified: json["isOtpVerified"],
        isKycVerified: json["isKycVerified"],
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
        "token": token,
        "tokenUser": tokenUser,
        "expiration": expiration.toIso8601String(),
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "dateofBirth": dateofBirth,
        "isOtpVerified": isOtpVerified,
        "isKycVerified": isKycVerified,
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
