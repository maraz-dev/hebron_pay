import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/home/domain/entity/transaction_entity.dart';
import 'package:hebron_pay/features/home/domain/usecase/transaction_usecase.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionUsecase usecase;
  TransactionCubit({required this.usecase}) : super(TransactionInitial());

  Future<List<TransactionEntity>?> getTransactions() async {
    emit(TransactionLoading());
    try {
      var transactionResponse = await usecase.call();
      emit(TransactionSuccess(userTrx: transactionResponse));
      return transactionResponse;
    } on SocketException catch (e) {
      emit(TransactionFailure(errorMessage: e.message));
    } catch (e) {
      emit(TransactionFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
