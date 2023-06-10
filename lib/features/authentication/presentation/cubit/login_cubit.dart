// ignore_for_file: unused_import

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/authentication/data/models/login_response_model.dart';
import 'package:hebron_pay/features/authentication/domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  LoginCubit({required this.loginUsecase}) : super(LoginInitial());

  Future<void> submitLogin(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await loginUsecase.call({"email": email, "password": password});
      emit(LoginSuccess());
    } on SocketException catch (e) {
      emit(LoginFailure(e.message));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
