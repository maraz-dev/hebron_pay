import 'package:hebron_pay/features/home/domain/entity/balance_entity.dart';
import 'package:hebron_pay/features/home/domain/repository/balance_repo.dart';

class BalanceUsecase {
  final BalanceRepo balanceRepository;

  BalanceUsecase({required this.balanceRepository});

  Future<BalanceEntity> call() async {
    return await balanceRepository.getBalance();
  }
}
