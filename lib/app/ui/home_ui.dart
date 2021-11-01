import 'package:astup/app/controllers/controllers.dart';
import 'package:astup/app/helpers/notification_api.dart';
import 'package:astup/app/ui/components/components.dart';
import 'package:astup/app/utils/constants.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_actions/quick_actions.dart';

import 'ui.dart';

const double fbuttonSize = 32;

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
          localizedTitle: 'settings.system'.tr,
          icon: "outline_qr_code_scanner_black_24dp")
    ]);
    quickActions.initialize((type) {
      if (type == 'qrScan') {
        Get.to(UIQRView());
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
                  actionsIconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  title: Text('home.title'.tr),
                  actions: [
                    IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          Get.to(SettingsUI());
                        }),
                  ],
                ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        arrowColor: AppThemes.white,
                        decoration:
                            const BoxDecoration(color: AppThemes.shamrockGreen),
                        currentAccountPicture:
                            Avatar(controller.firestoreUser.value!),
                        accountName: Text(controller.firestoreUser.value!.name),
                        accountEmail:
                            Text(controller.firestoreUser.value!.email),
                      ),
                      const ListTile(
                        leading: Icon(Icons.panorama_fish_eye_outlined),
                        title: Text("MOCK"),
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
                        leading: Icon(Icons.exit_to_app),
                        title: Text('settings.signOut'.tr),
                        onTap: () async {
                          await AuthController.to.signOut();
                        },
                      ),
                    ],
                  ),
                ),
                body: SafeArea(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 120),
                        // Text(
                        //     'Connection Status: ${SplashUI..toString()}'),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: Builder(
                  builder: (context) => FabCircularMenu(
                    key: fabKey,
                    // Cannot be `Alignment.center`
                    alignment: Alignment.bottomRight,
                    ringColor: AppThemes.lightGrey.withAlpha(90),
                    ringDiameter: 360.0,
                    ringWidth: 80.0,
                    fabSize: 64.0,
                    fabElevation: 32.0,
                    fabIconBorder: const CircleBorder(),
                    fabColor: AppThemes.shamrockGreen,
                    fabOpenIcon: const Icon(
                      Icons.menu,
                      color: AppThemes.white,
                      size: fbuttonSize,
                    ),
                    fabCloseIcon: const Icon(
                      Icons.close,
                      color: AppThemes.white,
                      size: fbuttonSize,
                    ),
                    fabMargin: const EdgeInsets.all(24.0),
                    animationDuration: const Duration(milliseconds: 800),
                    animationCurve: Curves.easeInOutCirc,
                    children: <Widget>[
                      RawMaterialButton(
                        child: const Icon(
                          Icons.qr_code_scanner_outlined,
                          color: AppThemes.shamrockGreen,
                          size: fbuttonSize,
                        ),
                        onPressed: () {
                          Get.to(UIQRView());
                          fabKey.currentState!.close();
                        },
                        shape: CircleBorder(),
                        padding: const EdgeInsets.all(24.0),
                      ),
                      RawMaterialButton(
                        child: const Icon(
                          Icons.history_outlined,
                          color: AppThemes.shamrockGreen,
                          size: fbuttonSize,
                        ),
                        onPressed: () {
                          // Get.to(UIQRView());
                          fabKey.currentState!.close();
                        },
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24.0),
                      ),
                      RawMaterialButton(
                        child: const Icon(
                          Icons.panorama_fish_eye_outlined,
                          color: AppThemes.shamrockGreen,
                          size: fbuttonSize,
                        ),
                        onPressed: () {
                          // Get.to(UIQRView());
                          fabKey.currentState!.close();
                        },
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24.0),
                      ),
                      RawMaterialButton(
                        child: const Icon(
                          Icons.message,
                          color: AppThemes.shamrockGreen,
                          size: fbuttonSize,
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
