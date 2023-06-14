import 'package:hebron_pay/features/authentication/domain/entities/login_entity.dart';
import 'package:hebron_pay/features/authentication/domain/repositories/login_repo.dart';

class LoginUsecase {
  final LoginRepository repository;

  LoginUsecase({required this.repository});

  Future<LoginEntity> call(Map<String, dynamic> mapBody) async {
    return await repository.login(mapBody);
  }
}
