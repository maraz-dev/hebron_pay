// ignore_for_file: avoid_print

import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/home/data/datasource/fund_wallet_remote.dart';
import 'package:hebron_pay/features/home/domain/repository/fund_wallet_repo.dart';

class FundWalletRepoImpl implements FundWalletRepo {
  final NetworkInfo networkInfo;
  final FundWalletRemoteData remoteData;

  FundWalletRepoImpl({required this.networkInfo, required this.remoteData});
  @override
  Future<String> fundWallet(Map<String, dynamic> map) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remoteData.fundWalletAPI(map);

        if (response.message != 'success' && response.error != null) {
          print(response.error['message']);
          throw response.error['message'];
        } else {
          print('Funding is ${response.message}');
          return response.data;
        }
      } on Exception catch (e) {
        print(e.toString());
        rethrow;
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }
}
