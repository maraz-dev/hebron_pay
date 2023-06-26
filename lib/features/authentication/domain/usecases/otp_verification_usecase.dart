import 'package:hebron_pay/core/domain/entity.dart';

import '../repositories/otp_verification_repo.dart';

class SendOTPUsecase {
  final OtpVerificationRepo repo;

  SendOTPUsecase({required this.repo});

  Future<String> call(String email) async {
    return await repo.sendOTP(email);
  }
}

class ValidateOTPUsecase {
  final OtpVerificationRepo repo;

  ValidateOTPUsecase({required this.repo});

  Future<String> call(String email, String inputPin) async {
    return await repo.validateOTP(email, inputPin);
  }
}
