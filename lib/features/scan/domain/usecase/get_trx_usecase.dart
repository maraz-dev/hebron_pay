import 'package:hebron_pay/features/scan/domain/entities/get_transaction_entity.dart';
import 'package:hebron_pay/features/scan/domain/repositories/get_trx_repo.dart';

class GetTrxUsecase {
  final GetTrxRepo repo;

  GetTrxUsecase({required this.repo});

  Future<GetTrxEntity> call(String reference) async {
    return await repo.getTransaction(reference);
  }
}
