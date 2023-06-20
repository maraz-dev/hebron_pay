// ignore_for_file: avoid_print

import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/home/data/datasource/transaction_remote.dart';
import 'package:hebron_pay/features/home/domain/entity/transaction_entity.dart';
import 'package:hebron_pay/features/home/domain/repository/transaction_remote.dart';

import '../models/transaction_model.dart';

class GetTransactionRepoImpl implements TransactionRepo {
  final NetworkInfo networkInfo;
  final GetTransactionRemote remote;

  GetTransactionRepoImpl({required this.networkInfo, required this.remote});
  @override
  Future<List<TransactionEntity>> getTransaction() async {
    List<TransactionEntity> transactions = [];
    if (await networkInfo.isConnected) {
      try {
        var response = await remote.getTransactionAPI();
        if (response.message != 'success' && response.error != null) {
          print(response.error['message']);
          throw (response.error['message']);
        } else {
          var responseList = response.data as List;
          transactions = responseList
              .map<TransactionEntity>(
                  (response) => TransactionModel.fromJson(response))
              .toList();
          return transactions;
        }
      } on Exception {
        rethrow;
      }
    } else {
      throw "You're not connected to Internet";
    }
  }
}
