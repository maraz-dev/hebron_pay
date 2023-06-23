import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String?> getToken() async {
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? token = await secureStorage.read(key: 'userToken');
  return token;
}
