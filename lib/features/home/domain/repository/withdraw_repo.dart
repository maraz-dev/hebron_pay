import 'package:hebron_pay/features/home/domain/entity/account_details_entity.dart';
import 'package:hebron_pay/features/home/domain/entity/bank_entity.dart';

abstract class WithdrawRepo {
  Future<List<BankEntity>> getBanks();
  Future<AccountDetailsEntity> resolveAccountDetails(
      Map<String, dynamic> mapBody);
  Future<String> withdraw(Map<String, dynamic> body);
}
