import '../repository/generate_eod_repo.dart';

class GenerateEodUsecase {
  final GenerateEodRepository repository;

  GenerateEodUsecase({required this.repository});
  Future<String> call() async {
    return await repository.generateEod();
  }
}
