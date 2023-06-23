import 'package:hebron_pay/features/home/domain/repository/withdraw_repo.dart';

class WithdrawUsecase {
  final WithdrawRepo repo;

  WithdrawUsecase({required this.repo});

  Future<String> call(Map<String, dynamic> body) async {
    return await repo.withdraw(body);
  }
}
