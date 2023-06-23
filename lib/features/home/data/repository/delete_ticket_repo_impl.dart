// ignore_for_file: avoid_print

import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/home/data/datasource/delete_ticket_remote.dart';
import 'package:hebron_pay/features/home/domain/repository/delete_ticket_repo.dart';

class DeleteTicketRepoImpl implements DeleteTicketRepo {
  final NetworkInfo networkInfo;
  final DeleteTicketRemote remote;

  DeleteTicketRepoImpl({required this.networkInfo, required this.remote});
  @override
  Future<String> deleteTicket(String reference) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remote.deleteTicketApi(reference);
        if (response.message != 'success' && response.error != null) {
          print(response.error['message']);
          throw (response.error['message']);
        } else {
          return response.data;
        }
      } catch (e) {
        rethrow;
      }
    } else {
      throw "You're not Connected to the Internet";
    }
  }
}
