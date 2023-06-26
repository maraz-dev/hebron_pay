import 'package:hebron_pay/features/profile/domain/repositories/change_pin_repo.dart';

class ChangePinUsecase {
  final ChangePinRepo repo;

  ChangePinUsecase({required this.repo});

  Future<String?> call(Map<String, dynamic> body) async {
    return await repo.changePin(body);
  }
}
