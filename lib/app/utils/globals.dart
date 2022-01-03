import 'dart:io';

import 'package:astup/app/models/index.dart';
import 'package:device_info_plus/device_info_plus.dart';

class Globals {
  static const String defaultLanguage = 'ru';

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(key: "ru", value: "Русский"), //Russian
    MenuOptionsModel(key: "kz", value: "Казақ"), //German
    MenuOptionsModel(key: "en", value: "English"), //English
  ];

  static Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  static void printMet(dynamic msg) {
    print('debug: $msg');
  }

}
class IpUtil {
  static bool verifyIp(final String ip) {
    // check correct structure
    final ipSplit = ip.split('.');
    if (ipSplit.length != 4) return false;

    // check four blocks are able to be converted to int
    final ipBlocks = <int>[];

    for (int i = 0; i < 4; i++) {
      // check if split string can be converted to int
      try {
        ipBlocks[i] = int.parse(ipSplit[i]);

        // check if block is between 0 and 255
        if (ipBlocks[i] < 0 || ipBlocks[i] > 255) return false;
      } catch (FormatException) {
        return false;
      }
    }
    return true;
  }
}