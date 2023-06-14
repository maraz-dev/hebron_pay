import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/profile/data/datasources/change_password_remote.dart';
import 'package:hebron_pay/features/profile/domain/repositories/change_password_repo.dart';

class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ChangePasswordRemote remoteDatasource;
  final NetworkInfo networkInfo;

  ChangePasswordRepoImpl(
      {required this.remoteDatasource, required this.networkInfo});
  @override
  Future<String?> changePassword(Map<String, dynamic> mapBody) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remoteDatasource.changePasswordremote(mapBody);
        if (response.message != 'success' && response.error != null) {
          throw (response.error['message']);
        } else {
          print(response.data);
          return response.data as String;
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
