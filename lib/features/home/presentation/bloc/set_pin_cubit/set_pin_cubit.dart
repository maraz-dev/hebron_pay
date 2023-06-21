import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/home/domain/usecase/set_pin_usecase.dart';

part 'set_pin_state.dart';

class SetPinCubit extends Cubit<SetPinState> {
  final SetPinUsecase usecase;
  SetPinCubit({required this.usecase}) : super(SetPinInitial());

  Future<String?> setPin(Map<String, dynamic> body) async {
    emit(SetPinLoading());
    try {
      var successMessage = await usecase.call(body);
      emit(SetPinSuccess());
      return successMessage;
    } on SocketException catch (e) {
      emit(SetPinFailure(errorMessage: e.message));
    } catch (e) {
      emit(SetPinFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
