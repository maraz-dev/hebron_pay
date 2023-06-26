// ignore_for_file: avoid_print

import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/profile/data/datasources/change_pin_remote.dart';

import '../../domain/repositories/change_pin_repo.dart';

class ChangePinRepoImpl implements ChangePinRepo {
  final ChangePinRemote remoteDatasource;
  final NetworkInfo networkInfo;

  ChangePinRepoImpl(
      {required this.remoteDatasource, required this.networkInfo});

  @override
  Future<String?> changePin(Map<String, dynamic> mapBody) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remoteDatasource.changePinApi(mapBody);
        if (response.message != 'success' && response.error != null) {
          throw (response.error['message']);
        } else {
          print(response.data);
          return response.data;
        }
      } on Exception catch (e) {
        print(e.toString());
        rethrow;
      }
    } else {
      throw ("You're not connected to the Internet");
    }
  }
}
