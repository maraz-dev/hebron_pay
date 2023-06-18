import 'package:hebron_pay/features/home/domain/repository/fund_wallet_repo.dart';

class FundWalletUsecase {
  final FundWalletRepo fundWalletRepo;

  FundWalletUsecase({required this.fundWalletRepo});

  Future<String> call(Map<String, dynamic> map) async {
    return await fundWalletRepo.fundWallet(map);
  }
}
