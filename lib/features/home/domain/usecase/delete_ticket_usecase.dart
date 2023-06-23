import 'package:hebron_pay/features/home/domain/repository/delete_ticket_repo.dart';

class DeleteTicketUsecase {
  final DeleteTicketRepo repo;

  DeleteTicketUsecase({required this.repo});

  Future<String> call(String reference) async {
    return await repo.deleteTicket(reference);
  }
}
