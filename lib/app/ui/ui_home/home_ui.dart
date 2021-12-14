// ignore_for_file: unnecessary_null_comparison

import 'package:astup/app/controllers/controllers.dart';
import 'package:astup/app/helpers/notification_api.dart';
import 'package:astup/app/res/colors.dart';
import 'package:astup/app/res/index.dart';
import 'package:astup/app/ui/components/components.dart';
import 'package:astup/app/ui/index_ui.dart';
import 'package:astup/app/ui/ui_home/index_home.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  String shortcut = 'no action set';
  int selectedIndex = 0;
  final Widget _sysVlanUI = const VlanUI();
  final Widget _myIpUI = const IPUI();
  // final Widget _myProfile = const MyProfile();

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    NotificationApi.init();
  }

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
                        leading: const Icon(Icons.panorama_fish_eye_outlined),
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
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: selectedIndex,
                  // showUnselectedLabels: false,
                  selectedItemColor: AppThemesColors.error,

                  selectedIconTheme: const IconThemeData(
                      // color: AppThemesColors.laPalma,
                      opacity: 1.0,
                      size: 32),
                  unselectedIconTheme: const IconThemeData(
                      // color: Colors.black45,
                      opacity: 0.5,
                      size: 24),

                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.wb_iridescent_outlined),
                      label: "VLAN",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.alt_route_outlined),
                      label: "IP Networks",
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.history_edu_outlined),
                    //   label: "History request",
                    // )
                  ],
                  onTap: (int index) {
                    onTapHandler(index);
                  },
                ),
                body: this.getBody(),
              ),
      );

  Widget getBody() {
    if (selectedIndex == 0) {
      return _sysVlanUI;
    } else {
      return _myIpUI;
    }
    // else if (selectedIndex == 1) {
    //   return _myIpUI;
    // }
    // else {
    //   return _myProfile;
    // }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
