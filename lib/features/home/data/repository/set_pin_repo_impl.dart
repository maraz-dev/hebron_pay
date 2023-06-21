import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/home/data/datasource/set_pin_remote.dart';
import 'package:hebron_pay/features/home/domain/repository/set_pin_repo.dart';

class SetPinRepoImpl implements SetPinRepo {
  final NetworkInfo networkInfo;
  final SetPinRemote remote;

  SetPinRepoImpl({required this.networkInfo, required this.remote});
  @override
  Future<String> setPin(Map<String, dynamic> map) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remote.setPinApi(map);
        if (response.message != 'success' && response.error != null) {
          print(response.error['message']);
          throw response.error['message'];
        } else {
          return response.data;
        }
      } on Exception {
        rethrow;
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }
}
