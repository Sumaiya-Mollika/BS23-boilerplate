import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

typedef ResponseCallback<R, E> = void Function(R response, E error);
const storage = FlutterSecureStorage();

const rightToLeft = Transition.rightToLeft;

const String kDateFormat = "EEEE, d MMMM yyyy";
const String placeholderAsset = "assets/images/placeholder.jpg";

class StorageKeys {
  static const String keyJwtToken = "keyJwtToken";
}
