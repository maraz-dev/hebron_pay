import 'package:equatable/equatable.dart';

class AccountDetailsEntity extends Equatable {
  final String accountNumber;
  final String accountName;

  const AccountDetailsEntity({
    required this.accountNumber,
    required this.accountName,
  });

  @override
  List<Object?> get props => [accountNumber, accountName];
}
