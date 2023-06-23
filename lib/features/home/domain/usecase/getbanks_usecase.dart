import 'package:hebron_pay/features/home/domain/entity/bank_entity.dart';
import 'package:hebron_pay/features/home/domain/repository/withdraw_repo.dart';

class GetBanksUsecase {
  final WithdrawRepo repo;

  GetBanksUsecase({required this.repo});

  Future<List<BankEntity>> call() async {
    return await repo.getBanks();
  }
}
