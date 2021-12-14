import 'package:astup/app/ui/index_ui.dart';
import 'package:astup/app/ui/ui_object/index_object.dart';
import 'package:astup/app/ui/ui_auth/ui_auth.dart';
import 'package:astup/app/ui/ui_object/object_ui.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => const SplashUI()),
    GetPage(name: '/signin', page: () => SignInUI()),
    GetPage(name: '/profile', page: () => ProfileUI()),
    GetPage(name: '/home', page: () => const HomeUI()),
    GetPage(name: '/settings', page: () => const SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
    GetPage(name: '/qrview', page: () => const UIQRView()),
    GetPage(name: '/object', page: () => const ObjectUi()),
    // GetPage(name: '/arview', page: () => ARHomeScreen()),
  ];
}
