import 'package:hebron_pay/core/domain/entity.dart';

abstract class OtpVerificationRepo {
  Future<String> sendOTP(String email);
  Future<ResponseEntity> validateOTP(String email, String inputPin);
}
