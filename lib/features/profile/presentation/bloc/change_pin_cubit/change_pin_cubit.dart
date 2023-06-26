import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/profile/domain/usecases/change_pin_usecase.dart';

part 'change_pin_state.dart';

class ChangePinCubit extends Cubit<ChangePinState> {
  final ChangePinUsecase usecase;
  ChangePinCubit({required this.usecase}) : super(ChangePinInitial());

  Future<String?> changePassword(Map<String, dynamic> body) async {
    emit(ChangePinLoading());
    try {
      final changePinResponse = await usecase.call(body);
      emit(ChangePinSuccess());
      return changePinResponse;
    } on SocketException catch (e) {
      emit(ChangePinFailure(errorMessage: e.message));
    } catch (e) {
      emit(ChangePinFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
