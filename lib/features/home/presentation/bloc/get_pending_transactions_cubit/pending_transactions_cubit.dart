import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/home/domain/entity/pending_transaction_entity.dart';
import 'package:hebron_pay/features/home/domain/usecase/pending_transaction_usecase.dart';

part 'pending_transactions_state.dart';

class PendingTransactionsCubit extends Cubit<PendingTransactionsState> {
  final PendingTransactionUsecase usecase;
  PendingTransactionsCubit({required this.usecase})
      : super(PendingTransactionsInitial());

  Future<List<PendingTransactionEntity>?> getPendingTransactions() async {
    emit(PendingTransactionsLoading());
    try {
      var pendingTransactionResponse = await usecase.call();
      emit(PendingTransactionsSuccess(pendingTrx: pendingTransactionResponse));
      return pendingTransactionResponse;
    } on SocketException catch (e) {
      emit(PendingTransactionsFailure(errorMessage: e.message));
    } catch (e) {
      emit(PendingTransactionsFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
