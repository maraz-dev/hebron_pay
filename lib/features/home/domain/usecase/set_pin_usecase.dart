import 'package:hebron_pay/features/home/domain/repository/set_pin_repo.dart';

class SetPinUsecase {
  final SetPinRepo repo;

  SetPinUsecase({required this.repo});

  Future<String> call(Map<String, dynamic> mapBody) async {
    return await repo.setPin(mapBody);
  }
}
