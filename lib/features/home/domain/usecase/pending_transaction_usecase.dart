import 'package:hebron_pay/features/home/domain/entity/pending_transaction_entity.dart';

import '../repository/pending_transaction_repo.dart';

class PendingTransactionUsecase {
  final PendingTransactionRepo pendingTransactionRepo;

  PendingTransactionUsecase({required this.pendingTransactionRepo});

  Future<List<PendingTransactionEntity>> call() async {
    return await pendingTransactionRepo.getPendingTransaction();
  }
}
