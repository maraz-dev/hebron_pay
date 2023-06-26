import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/profile/domain/usecases/change_password_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ChangePasswordUsecase changePasswordUsecase;
  ProfileCubit({required this.changePasswordUsecase}) : super(ProfileInitial());

  Future<String?> changePassword(Map<String, dynamic> body) async {
    emit(ProfileLoading());
    try {
      final changePasswordResponse = await changePasswordUsecase.call(body);
      emit(ProfileSuccess());
      return changePasswordResponse;
    } on SocketException catch (e) {
      emit(ProfileFailure(errorMessage: e.message));
    } catch (e) {
      emit(ProfileFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
