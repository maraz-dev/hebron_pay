import 'package:hebron_pay/features/home/domain/entity/pending_transaction_entity.dart';

class PendingTransactionModel extends PendingTransactionEntity {
  // int id;
  // String description;
  // int amount;
  // String reference;
  // String type;
  // String date;
  // String time;
  // int hebronPayWalletId;

  const PendingTransactionModel({
    required super.id,
    required super.description,
    required super.amount,
    required super.reference,
    required super.type,
    required super.date,
    required super.time,
    required super.hebronPayWalletId,
  });

  factory PendingTransactionModel.fromJson(Map<String, dynamic> json) =>
      PendingTransactionModel(
        id: json["id"],
        description: json["description"],
        amount: json["amount"],
        reference: json["reference"],
        type: json["type"],
        date: json["date"],
        time: json["time"],
        hebronPayWalletId: json["hebronPayWalletId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "amount": amount,
        "reference": reference,
        "type": type,
        "date": date,
        "time": time,
        "hebronPayWalletId": hebronPayWalletId,
      };
}
