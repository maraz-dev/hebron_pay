import 'package:equatable/equatable.dart';

class BalanceEntity extends Equatable {
  final int id;
  final double walletBalance;
  final int walletPin;

  const BalanceEntity({
    required this.id,
    required this.walletBalance,
    required this.walletPin,
  });

  @override
  List<Object?> get props => [id, walletBalance, walletPin];
}
