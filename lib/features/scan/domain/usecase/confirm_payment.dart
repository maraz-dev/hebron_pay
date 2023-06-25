import 'package:hebron_pay/features/scan/domain/repositories/confirm_payment.dart';

class ConfirmPaymentUsecase {
  final ConfirmPaymentRepo repo;

  ConfirmPaymentUsecase({required this.repo});

  Future<String> call(Map<String, dynamic> mapBody) async {
    return await repo.confirmPayment(mapBody);
  }
}
