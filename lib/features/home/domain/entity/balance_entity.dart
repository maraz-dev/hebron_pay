import 'package:equatable/equatable.dart';

class BalanceEntity extends Equatable {
  final String currency;
  final String availableBalance;
  final String ledgerBalance;

  const BalanceEntity({
    required this.currency,
    required this.availableBalance,
    required this.ledgerBalance,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [currency, availableBalance, ledgerBalance];
}
