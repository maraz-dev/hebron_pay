import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/authentication/domain/usecases/create_account_usecase.dart';

part 'sign_up_cubit_state.dart';

class SignUpCubit extends Cubit<SignUpCubitState> {
  final CreateAccountUsecase createAccountUsecase;
  SignUpCubit({required this.createAccountUsecase})
      : super(SignUpCubitInitial());

  Future<String?> submitSignUp(Map<String, dynamic> map) async {
    emit(SignUpLoading());
    try {
      String response = await createAccountUsecase.call(map);
      emit(SignUpSuccess());
      return response;
    } on SocketException catch (e) {
      emit(SignUpFailure(e.message));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
    return null;
  }
}
