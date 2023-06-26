import 'package:hebron_pay/core/data/user_model.dart';
import 'package:hebron_pay/core/data/user_remote.dart';
import 'package:hebron_pay/core/domain/user_entity.dart';
import 'package:hebron_pay/core/domain/user_repository.dart';
import 'package:hebron_pay/core/network/network_info.dart';

class UserRepoImpl implements UserRepo {
  final UserRemote remote;
  final NetworkInfo networkInfo;

  UserRepoImpl({
    required this.remote,
    required this.networkInfo,
  });
  @override
  Future<HebronPayWalletEntity> getHPWallet() async {
    if (await networkInfo.isConnected) {
      if (await networkInfo.isConnected) {
        var response = await remote.getUserDetails();

        if (response.message != 'success' && response.error != null) {
          throw (response.error['message']);
        } else {
          return HebronPayWallet.fromJson(response.data['hebronPayWallet']);
        }
      } else {
        throw "You're not connected to the Internet";
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }

  @override
  Future<SubAccountEntity> getSubAccount() async {
    if (await networkInfo.isConnected) {
      if (await networkInfo.isConnected) {
        var response = await remote.getUserDetails();

        if (response.message != 'success' && response.error != null) {
          throw (response.error['message']);
        } else {
          return SubAccount.fromJson(response.data['subAccount']);
        }
      } else {
        throw "You're not connected to the Internet";
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }

  @override
  Future<UserEntity> getUserDetails() async {
    if (await networkInfo.isConnected) {
      var response = await remote.getUserDetails();

      if (response.message != 'success' && response.error != null) {
        throw (response.error['message']);
      } else {
        return UserModel.fromJson(response.data);
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }
}
