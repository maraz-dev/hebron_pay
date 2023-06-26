import 'package:hebron_pay/core/domain/user_entity.dart';
import 'package:hebron_pay/core/domain/user_repository.dart';

class UserUsecase {
  final UserRepo userRepo;

  UserUsecase({required this.userRepo});

  Future<UserEntity> call() async {
    return userRepo.getUserDetails();
  }
}

class HebronPayWalletUsecase {
  final UserRepo userRepo;

  HebronPayWalletUsecase({required this.userRepo});

  Future<HebronPayWalletEntity> call() async {
    return userRepo.getHPWallet();
  }
}

class SubAccountUsecase {
  final UserRepo userRepo;

  SubAccountUsecase({required this.userRepo});

  Future<SubAccountEntity> call() async {
    return userRepo.getSubAccount();
  }
}
