import 'package:hebron_pay/features/home/data/datasource/generate_eod_remote.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repository/generate_eod_repo.dart';

class GenerateEodRepoImpl implements GenerateEodRepository {
  final GenerateEodRemote remote;
  final NetworkInfo networkInfo;

  GenerateEodRepoImpl({required this.remote, required this.networkInfo});
  @override
  Future<String> generateEod() async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remote.generateEodAPI();
        if (response.message != 'success' && response.error != null) {
          print(response.error['message']);
          throw response.error['message'];
        } else {
          return response.data;
        }
      } on Exception {
        rethrow;
      }
    } else {
      throw "You're not connected to the Internet";
    }
  }
}
