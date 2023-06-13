import 'package:hebron_pay/features/authentication/domain/entities/login_entity.dart';

import '../../data/models/login_response_model.dart';

abstract class LoginRepository {
  Future<LoginEntity> login(Map<String, dynamic> mapBody);
}
