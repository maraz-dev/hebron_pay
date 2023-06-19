// ignore_for_file: avoid_print

import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/home/data/datasource/get_pending_transaction_remote.dart';
import 'package:hebron_pay/features/home/data/models/pending_transaction_model.dart';
import 'package:hebron_pay/features/home/domain/entity/pending_transaction_entity.dart';
import 'package:hebron_pay/features/home/domain/repository/pending_transaction_repo.dart';

class GetPendingTransactionRepoImpl implements PendingTransactionRepo {
  final NetworkInfo networkInfo;
  final GetPendingTransactionRemote remote;

  GetPendingTransactionRepoImpl(
      {required this.networkInfo, required this.remote});
  @override
  Future<List<PendingTransactionEntity>> getPendingTransaction() async {
    List<PendingTransactionEntity> pendingTransactions = [];
    if (await networkInfo.isConnected) {
      try {
        var response = await remote.getPendingTransactionAPI();
        if (response.message != 'success' && response.error != null) {
          print(response.error['message']);
          throw (response.error['message']);
        } else {
          var responseList = response.data as List;
          pendingTransactions = responseList
              .map<PendingTransactionEntity>(
                  (response) => PendingTransactionModel.fromJson(response))
              .toList();
          return pendingTransactions;
        }
      } on Exception {
        rethrow;
      }
    } else {
      throw "You're not connected to Internet";
    }
  }
}
