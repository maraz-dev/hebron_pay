import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/scan/data/datasources/confirm_payment_remote.dart';
import 'package:hebron_pay/features/scan/domain/repositories/confirm_payment.dart';

class ConfirmPaymentRepoImpl implements ConfirmPaymentRepo {
  final NetworkInfo networkInfo;
  final ConfirmPaymentRemote remote;

  ConfirmPaymentRepoImpl({required this.networkInfo, required this.remote});

  @override
  Future<String> confirmPayment(Map<String, dynamic> body) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remote.confirmPaymentApi(body);
        if (response.message != 'success' && response.error != null) {
          throw (response.error['message']);
        } else {
          return response.data as String;
        }
      } catch (e) {
        rethrow;
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }
}
