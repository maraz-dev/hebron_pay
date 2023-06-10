import 'package:hebron_pay/features/authentication/data/models/login_response_model.dart';
import 'package:hebron_pay/features/authentication/domain/repositories/login_repo.dart';

class LoginUsecase {
  final LoginRepository repository;

  LoginUsecase(this.repository);

  Future<LoginResponseModel> call(Map<String, dynamic> mapBody) async {
    return await repository.login(mapBody);
  }
}
