import 'package:hebron_pay/core/data/model.dart';
import 'package:hebron_pay/core/domain/entity.dart';
import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/authentication/data/datasources/email_verification_remote.dart';

import '../../domain/repositories/otp_verification_repo.dart';

class OtpVerificationRepoImpl implements OtpVerificationRepo {
  final EmailVerificationRemote emailVerificationRemote;
  final NetworkInfo networkInfo;

  OtpVerificationRepoImpl({
    required this.emailVerificationRemote,
    required this.networkInfo,
  });
  @override
  Future<String> sendOTP(String email) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await emailVerificationRemote.sendOTP(email);

        if (response.message != 'success' && response.error != null) {
          throw response.error['message'];
        } else {
          var message = response.data;
          return message;
        }
      } on Exception catch (e) {
        print(e.toString());
        rethrow;
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }

  @override
  Future<ResponseEntity> validateOTP(String email, String inputPin) async {
    if (await networkInfo.isConnected) {
      try {
        var response =
            await emailVerificationRemote.validateOTP(email, inputPin);

        if (response.message != 'success' && response.error != null) {
          throw response.error['message'];
        } else {
          var message = response.data;
          return message;
        }
      } on Exception {
        rethrow;
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }
}
