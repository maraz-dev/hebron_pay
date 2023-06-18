import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/core/domain/entity.dart';
import 'package:hebron_pay/features/authentication/domain/usecases/otp_verification_usecase.dart';

part 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final SendOTPUsecase sendOTPUsecase;
  final ValidateOTPUsecase validateOTPUsecase;
  EmailVerificationCubit(
      {required this.sendOTPUsecase, required this.validateOTPUsecase})
      : super(EmailVerificationInitial());

  Future<String?> sendOTP(String email) async {
    emit(EmailVerificationLoading());
    try {
      var successMessage = await sendOTPUsecase.call(email);
      emit(const EmailVerificationSuccess(usecase: 'SEND_OTP'));
      return successMessage.toString();
    } on SocketException catch (e) {
      emit(EmailVerificationFailed(errorMessage: e.message));
    } catch (e) {
      emit(EmailVerificationFailed(errorMessage: e.toString()));
    }
    return null;
  }

  Future<String?> validateOtp(String email, String inputPin) async {
    emit(EmailVerificationLoading());
    try {
      var successMessage =
          await validateOTPUsecase.call(email, inputPin) as String;
      emit(const EmailVerificationSuccess(usecase: 'VALIDATE_OTP'));
      return successMessage;
    } on SocketException catch (e) {
      emit(EmailVerificationFailed(errorMessage: e.message));
    } catch (e) {
      emit(EmailVerificationFailed(errorMessage: e.toString()));
    }
    return null;
  }
}
