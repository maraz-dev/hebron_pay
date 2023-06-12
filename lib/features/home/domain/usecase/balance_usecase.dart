import 'package:hebron_pay/features/home/data/models/balance_model.dart';
import 'package:hebron_pay/features/home/domain/repository/balance_repo.dart';

class BalanceUsecase {
  final BalanceRepo balanceRepository;

  BalanceUsecase({required this.balanceRepository});

  Future<BalanceModel> call() async {
    return await balanceRepository.getBalance();
  }
}
