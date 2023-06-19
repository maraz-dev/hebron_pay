import 'package:hebron_pay/features/home/domain/entity/pending_transaction_entity.dart';

abstract class PendingTransactionRepo {
  Future<List<PendingTransactionEntity>> getPendingTransaction();
}
