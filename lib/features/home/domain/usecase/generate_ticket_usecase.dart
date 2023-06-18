import 'package:hebron_pay/features/home/domain/repository/generate_ticket_repo.dart';

class GenerateTicketUsecase {
  final GenerateTicketRepo generateTicketRepo;

  GenerateTicketUsecase({required this.generateTicketRepo});

  Future<String> call(Map<String, dynamic> map) async {
    return await generateTicketRepo.generateTicket(map);
  }
}
