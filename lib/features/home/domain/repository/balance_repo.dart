import 'package:hebron_pay/features/home/data/models/balance_model.dart';

abstract class BalanceRepo {
  Future<BalanceModel> getBalance();
}
