import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/scan/domain/usecase/confirm_payment.dart';

part 'confirm_payment_state.dart';

class ConfirmPaymentCubit extends Cubit<ConfirmPaymentState> {
  final ConfirmPaymentUsecase usecase;
  ConfirmPaymentCubit({required this.usecase}) : super(ConfirmPaymentInitial());

  Future<String?> confirmPayment(Map<String, dynamic> body) async {
    emit(ConfirmPaymentLoading());
    try {
      var successMessage = await usecase.call(body);
      emit(ConfirmPaymentSuccess());
      return successMessage;
    } on SocketException catch (e) {
      emit(ConfirmPaymentFailure(errorMessage: e.message));
    } catch (e) {
      emit(ConfirmPaymentFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
