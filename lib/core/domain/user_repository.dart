import 'package:hebron_pay/core/domain/user_entity.dart';

abstract class UserRepo {
  Future<UserEntity> getUserDetails();
  Future<HebronPayWalletEntity> getHPWallet();
  Future<SubAccountEntity> getSubAccount();
}
