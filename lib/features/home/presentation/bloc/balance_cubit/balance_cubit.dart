import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/features/home/domain/entity/balance_entity.dart';
import 'package:hebron_pay/features/home/domain/usecase/balance_usecase.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  final BalanceUsecase balanceUsecase;
  BalanceCubit({required this.balanceUsecase}) : super(BalanceInitial());

  Future<BalanceEntity?> showBalance() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    emit(BalanceLoading());
    try {
      var details = await balanceUsecase.call();
      emit(BalanceSuccess(walletDetails: details));
      await storage.write(key: 'userPin', value: details.walletPin.toString());
      return details;
    } on SocketException catch (e) {
      emit(BalanceFailure(errorMessage: e.message));
    } catch (e) {
      emit(BalanceFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
