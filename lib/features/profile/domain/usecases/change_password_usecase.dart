import 'package:hebron_pay/features/profile/domain/repositories/change_password_repo.dart';

class ChangePasswordUsecase {
  final ChangePasswordRepo repository;

  ChangePasswordUsecase({required this.repository});

  Future<String?> call(Map<String, dynamic> map) async {
    return await repository.changePassword(map);
  }
}
