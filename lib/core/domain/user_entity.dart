import 'package:equatable/equatable.dart';
import 'package:hebron_pay/core/data/user_model.dart';

class UserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime dateofBirth;
  final bool isOtpVerified;
  final bool isKycVerified;
  final bool isPinSet;
  final int subAccountId;
  final SubAccount subAccount;
  final int hebronPayWalletId;
  final HebronPayWallet hebronPayWallet;
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

  const UserEntity({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dateofBirth,
    required this.isOtpVerified,
    required this.isKycVerified,
    required this.isPinSet,
    required this.subAccountId,
    required this.subAccount,
    required this.hebronPayWalletId,
    required this.hebronPayWallet,
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
    this.lockoutEnd,
    required this.lockoutEnabled,
    required this.accessFailedCount,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HebronPayWalletEntity extends Equatable {
  final int id;
  final int walletBalance;
  final int walletPin;

  const HebronPayWalletEntity({
    required this.id,
    required this.walletBalance,
    required this.walletPin,
  });
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SubAccountEntity extends Equatable {
  final int id;
  final int flutterwaveSubAccountId;
  final String accountReference;
  final String accountName;
  final String barterId;
  final String email;
  final String mobilenumber;
  final String country;
  final String nuban;
  final String bankName;
  final String bankCode;
  final String status;
  final DateTime createdAt;

  const SubAccountEntity({
    required this.id,
    required this.flutterwaveSubAccountId,
    required this.accountReference,
    required this.accountName,
    required this.barterId,
    required this.email,
    required this.mobilenumber,
    required this.country,
    required this.nuban,
    required this.bankName,
    required this.bankCode,
    required this.status,
    required this.createdAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
