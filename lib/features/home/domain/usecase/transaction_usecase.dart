import '../entity/transaction_entity.dart';
import '../repository/transaction_remote.dart';

class TransactionUsecase {
  final TransactionRepo transactionRepo;

  TransactionUsecase({required this.transactionRepo});

  Future<List<TransactionEntity>> call() async {
    return await transactionRepo.getTransaction();
  }
}
