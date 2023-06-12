import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String token;
  final String tokenUser;
  final DateTime expiration;
  final String firstName;
  final String lastName;
  final String gender;
  final String dateofBirth;
  final bool isOtpVerified;
  final bool isKycVerified;
  final String id;
  final String userName;
  final String normalizedUserName;
  final String email;
  final String normalizedEmail;
  final bool emailConfirmed;
  final String passwordHash;
  final String securityStamp;
  final String concurrencyStamp;
  final String phoneNumber;
  final bool phoneNumberConfirmed;
  final bool twoFactorEnabled;
  final dynamic lockoutEnd;
  final bool lockoutEnabled;
  final int accessFailedCount;

  const LoginEntity(
      {required this.token,
      required this.tokenUser,
      required this.expiration,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.dateofBirth,
      required this.isOtpVerified,
      required this.isKycVerified,
      required this.id,
      required this.userName,
      required this.normalizedUserName,
      required this.email,
      required this.normalizedEmail,
      required this.emailConfirmed,
      required this.passwordHash,
      required this.securityStamp,
      required this.concurrencyStamp,
      required this.phoneNumber,
      required this.phoneNumberConfirmed,
      required this.twoFactorEnabled,
      required this.lockoutEnd,
      required this.lockoutEnabled,
      required this.accessFailedCount});

  @override
  List<Object?> get props => [token, firstName];
}
