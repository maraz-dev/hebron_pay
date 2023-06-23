import 'package:hebron_pay/features/home/domain/entity/account_details_entity.dart';
import 'package:hebron_pay/features/home/domain/repository/withdraw_repo.dart';

class ResolveAcctDetailsUsecase {
  final WithdrawRepo repo;

  ResolveAcctDetailsUsecase({required this.repo});

  Future<AccountDetailsEntity> call(Map<String, dynamic> map) async {
    return await repo.resolveAccountDetails(map);
  }
}
