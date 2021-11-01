import 'package:astup/app/models/models.dart';

class Globals {
  static const String defaultLanguage = 'ru';

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(key: "ru", value: "Русский"), //Russian
    MenuOptionsModel(key: "kz", value: "Казақ"), //German
    MenuOptionsModel(key: "en", value: "English"), //English
  ];
}