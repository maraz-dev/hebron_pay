import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/home/domain/entity/balance_entity.dart';
import 'package:hebron_pay/features/home/domain/usecase/balance_usecase.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  final BalanceUsecase balanceUsecase;
  BalanceCubit({required this.balanceUsecase}) : super(BalanceInitial());

  Future<BalanceEntity?> showBalance() async {
    emit(BalanceLoading());
    try {
      emit(BalanceSuccess());
      return await balanceUsecase.call();
    } on SocketException catch (e) {
      emit(BalanceFailure(errorMessage: e.message));
    } catch (e) {
      emit(BalanceFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
