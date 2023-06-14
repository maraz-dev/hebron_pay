import 'package:hebron_pay/features/authentication/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<LoginEntity> login(Map<String, dynamic> mapBody);
}
