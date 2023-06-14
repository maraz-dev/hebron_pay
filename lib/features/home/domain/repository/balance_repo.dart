import 'package:hebron_pay/features/home/domain/entity/balance_entity.dart';

abstract class BalanceRepo {
  Future<BalanceEntity> getBalance();
}
