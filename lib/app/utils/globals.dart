import 'package:astup/app/models/index.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
class Globals {
  static const String defaultLanguage = 'ru';

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(key: "ru", value: "Русский"), //Russian
    MenuOptionsModel(key: "kz", value: "Казақ"), //German
    MenuOptionsModel(key: "en", value: "English"), //English
  ];

  static Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}