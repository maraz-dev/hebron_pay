import 'package:hebron_pay/core/network/network_info.dart';
import 'package:hebron_pay/features/home/domain/repository/generate_ticket_repo.dart';

import '../datasource/generate_ticket_remote.dart';

class GenerateTicketRepoImpl implements GenerateTicketRepo {
  final GenerateTicketRemote remote;
  final NetworkInfo networkInfo;

  GenerateTicketRepoImpl({required this.remote, required this.networkInfo});
  @override
  Future<String> generateTicket(Map<String, dynamic> map) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remote.generateTicketAPI(map);
        if (response.message != 'success' && response.error != null) {
          print(response.error['message']);
          throw (response.error['message']);
        } else {
          return response.message;
        }
      } catch (e) {
        rethrow;
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }
}
