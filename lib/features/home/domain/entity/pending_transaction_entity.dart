import 'package:equatable/equatable.dart';

class PendingTransactionEntity extends Equatable {
  final int id;
  final String description;
  final int amount;
  final String reference;
  final String type;
  final String date;
  final String time;
  final int hebronPayWalletId;

  const PendingTransactionEntity({
    required this.id,
    required this.description,
    required this.amount,
    required this.reference,
    required this.type,
    required this.date,
    required this.time,
    required this.hebronPayWalletId,
  });

  @override
  List<Object?> get props => [];
}
