import 'package:hebron_pay/features/scan/domain/entities/get_transaction_entity.dart';

abstract class GetTrxRepo {
  Future<GetTrxEntity> getTransaction(String reference);
}
