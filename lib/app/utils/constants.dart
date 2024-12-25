import 'package:flutter_secure_storage/flutter_secure_storage.dart';

typedef ResponseCallback<R, E> = void Function(R response, E error);
const storage = FlutterSecureStorage();

class StorageKeys {
  static const String keyJwtToken = "keyJwtToken";

}