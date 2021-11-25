// ignore_for_file: unnecessary_null_comparison

import 'package:astup/app/controllers/controllers.dart';
import 'package:astup/app/helpers/notification_api.dart';
import 'package:astup/app/res/index.dart';
import 'package:astup/app/ui/components/components.dart';
import 'package:astup/app/utils/constants.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:flutter/services.dart';

import 'ui.dart';

const double fbuttonSize = 32;
const double fbuttonRadius = 32;

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  String shortcut = 'no action set';

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  void initState() {
    const QuickActions quickActions = QuickActions();

    super.initState();
    NotificationApi.init();
    listenNotifications();
    quickActions.setShortcutItems([
      ShortcutItem(
          type: 'qrScan',
          localizedTitle: 'functions.QRscanner'.tr,
          icon: "outline_qr_code_scanner_black_24dp")
    ]);
    quickActions.initialize((type) {
      if (type == 'qrScan') {
        ;
      }
    });
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onTapNotification);
  void onTapNotification(String? payload) => Get.to(HomeUI);

  @override
  Widget build(BuildContext context) => GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) => controller.firestoreUser.value!.uid == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  actionsIconTheme: const IconThemeData(),
                  title: Text('home.title'.tr),
                  actions: [
                    IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          Get.to(const SettingsUI());
                        }),
                  ],
                ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        arrowColor: AppThemesColors.white,
                        margin: const EdgeInsets.only(bottom: 0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        currentAccountPicture:
                            Avatar(user: controller.firestoreUser.value!),
                        accountName: Text(controller.firestoreUser.value!.name),
                        accountEmail:
                            Text(controller.firestoreUser.value!.email),
                      ),
                      ListTile(
                        leading: Icon(Icons.panorama_fish_eye_outlined),
                        title:
                            Text(Theme.of(context).iconTheme.color.toString()),
                      ),
                      const Divider(
                        thickness: 2.0,
                      ),
                      const ListTile(
                        leading: Icon(Icons.panorama_fish_eye_outlined),
                        title: Text("MOCK"),
                      ),
                      const ListTile(
                        leading: Icon(Icons.panorama_fish_eye_outlined),
                        title: Text("MOCK"),
                      ),
                      const ListTile(
                        leading: Icon(Icons.panorama_fish_eye_outlined),
                        title: Text("MOCK"),
                      ),
                      const Divider(
                        thickness: 2.0,
                      ),
                      ListTile(
                        leading: const Icon(Icons.exit_to_app),
                        title: Text('settings.signOut'.tr),
                        onTap: () async {
                          await AuthController.to.signOut();
                        },
                      ),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://i.ytimg.com/vi/a19EY3YNStA/maxresdefault.jpg"),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 130,
                        left: 20,
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.white,
                          height: 40,
                          width: 80,
                          child: Text(
                            "Burger",
                            textScaleFactor: 1.5,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 130,
                        right: 20,
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.white,
                          height: 40,
                          width: 80,
                          child: Text(
                            "10 % off",
                            textScaleFactor: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomSheet: Text("Hello "),
                // SafeArea(
                //   child: Center(
                //     child: Column(
                //       children: const <Widget>[
                //         SizedBox(height: 120),
                //         // Text(
                //         //     'Connection Status: ${SplashUI..toString()}'),
                //       ],
                //     ),
                //   ),
                // ),
                floatingActionButton: Builder(
                  builder: (context) => FabCircularMenu(
                    key: fabKey,
                    // Cannot be `Alignment.center`
                    alignment: Alignment.bottomRight,
                    ringColor:
                        (Theme.of(context).brightness != Brightness.light)
                            ? AppThemes.black.withAlpha(15)
                            : AppThemes.Success,
                    ringDiameter: 360.0,
                    ringWidth: 80.0,
                    fabSize: 64.0,
                    fabElevation: 32.0,
                    fabIconBorder: const CircleBorder(),
                    fabColor: (Theme.of(context).brightness != Brightness.light)
                        ? Theme.of(context).colorScheme.primary
                        : AppThemes.Success,
                    // AppThemesColors.forestGreen,
                    fabOpenIcon: const Icon(
                      Icons.menu,
                      color: AppThemes.whiteLilac,
                      size: fbuttonSize,
                    ),
                    fabCloseIcon: const Icon(
                      Icons.close,
                      color: AppThemes.whiteLilac,
                      size: fbuttonSize,
                    ),
                    fabMargin: const EdgeInsets.all(24.0),
                    animationDuration: const Duration(milliseconds: 800),
                    animationCurve: Curves.easeInOutCirc,
                    children: <Widget>[
                      RawMaterialButton(
                        child: CircleAvatar(
                          backgroundColor:
                              (Theme.of(context).brightness != Brightness.light)
                                  ? Theme.of(context).colorScheme.primary
                                  : AppThemes.Success,
                          radius: fbuttonRadius,
                          child: const Icon(
                            Icons.qr_code_scanner_outlined,
                            color: AppThemesColors.whiteLilac,
                            size: fbuttonSize,
                          ),
                        ),
                        onPressed: () {
                          Get.to(const UIQRView());
                          fabKey.currentState!.close();
                        },
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24.0),
                      ),
                      RawMaterialButton(
                        child: CircleAvatar(
                          backgroundColor:
                              (Theme.of(context).brightness != Brightness.light)
                                  ? Theme.of(context).colorScheme.primary
                                  : AppThemes.Success,
                          radius: fbuttonRadius,
                          child: const Icon(
                            Icons.history_outlined,
                            color: AppThemesColors.whiteLilac,
                            size: fbuttonSize,
                          ),
                        ),
                        onPressed: () {
                          // Get.to(UIQRView());
                          fabKey.currentState!.close();
                        },
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24.0),
                      ),
                      RawMaterialButton(
                        child: CircleAvatar(
                          backgroundColor:
                              (Theme.of(context).brightness != Brightness.light)
                                  ? Theme.of(context).colorScheme.primary
                                  : AppThemes.Success,
                          radius: fbuttonRadius,
                          child: const Icon(
                            Icons.view_in_ar_outlined,
                            color: AppThemesColors.whiteLilac,
                            size: fbuttonSize,
                          ),
                        ),
                        onPressed: () {
                          // Get.to(ARHomeScreen());
                          fabKey.currentState!.close();
                        },
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24.0),
                      ),
                      RawMaterialButton(
                        child: CircleAvatar(
                          backgroundColor:
                              (Theme.of(context).brightness != Brightness.light)
                                  ? Theme.of(context).colorScheme.primary
                                  : AppThemes.Success,
                          radius: fbuttonRadius,
                          child: const Icon(
                            Icons.message,
                            color: AppThemesColors.whiteLilac,
                            size: fbuttonSize,
                          ),
                        ),
                        onPressed: () {
                          NotificationApi.showNotification(
                              title: 'hello', body: "worold", payload: null);
                          // Get.to(UIQRView());
                          fabKey.currentState!.close();
                        },
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24.0),
                      ),
                    ],
                  ),
                ),
              ),
      );
}
