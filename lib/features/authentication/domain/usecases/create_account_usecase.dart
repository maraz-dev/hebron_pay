import 'package:hebron_pay/features/authentication/data/models/create_account_model.dart';
import 'package:hebron_pay/features/authentication/domain/repositories/create_account_repo.dart';

class CreateAccountUsecase {
  final CreateAccountRepo createAccountRepo;

  CreateAccountUsecase({required this.createAccountRepo});

  Future<String> call(Map<String, dynamic> mapBody) async {
    return await createAccountRepo.createAccount(mapBody);
  }
}
