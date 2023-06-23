import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/home/domain/usecase/withdraw_usecase.dart';

part 'withdraw_state.dart';

class WithdrawCubit extends Cubit<WithdrawState> {
  final WithdrawUsecase usecase;
  WithdrawCubit({required this.usecase}) : super(WithdrawInitial());

  Future<String?> withdrawFunds(Map<String, dynamic> body) async {
    emit(WithdrawLoading());
    try {
      var responseMessage = await usecase.call(body);
      emit(WithdrawSuccess());
      return responseMessage;
    } on SocketException catch (e) {
      emit(WithdrawFailure(errorMessage: e.message));
    } catch (e) {
      emit(WithdrawFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
