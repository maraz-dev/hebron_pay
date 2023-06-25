import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/scan/data/datasources/get_transaction_remote.dart';
import 'package:hebron_pay/features/scan/data/models/get_transaction_model.dart';
import 'package:hebron_pay/features/scan/domain/entities/get_transaction_entity.dart';
import 'package:hebron_pay/features/scan/domain/repositories/get_trx_repo.dart';

class GetTrxRepoImpl implements GetTrxRepo {
  final NetworkInfo networkInfo;
  final GetScannedTransactionRemote remote;

  GetTrxRepoImpl({required this.networkInfo, required this.remote});
  @override
  Future<GetTrxEntity> getTransaction(String reference) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remote.getTransactionApi(reference);
        if (response.message != 'success' && response.error != null) {
          throw (response.error['message']);
        } else {
          return GetTransactionModel.fromJson(response.data);
        }
      } catch (e) {
        rethrow;
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }
}
