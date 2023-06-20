import 'package:hebron_pay/features/home/domain/entity/transaction_entity.dart';

abstract class TransactionRepo {
  Future<List<TransactionEntity>> getTransaction();
}
