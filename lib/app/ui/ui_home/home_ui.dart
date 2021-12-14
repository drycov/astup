// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:astup/app/controllers/controllers.dart';
import 'package:astup/app/helpers/notification_api.dart';
import 'package:astup/app/res/colors.dart';
import 'package:astup/app/res/index.dart';
import 'package:astup/app/ui/components/index.dart';
import 'package:astup/app/ui/index_ui.dart';
import 'package:astup/app/ui/ui_home/index_home.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  String shortcut = 'no action set';
  String locCnName = '';
  int selectedIndex = 0;
  final Widget _sysVlanUI = const VlanUI();
  final Widget _myIpUI = const IPUI();
  final AuthController controller = AuthController.to;

  // final Widget _myProfile = const MyProfile();

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  void initState() {
    // Demonstrates configuring the database directly
    final FirebaseDatabase database = FirebaseDatabase();
    database.reference().child('location').get().then((DataSnapshot? snapshot) {
      // print(
      // 'Connected to directly configured database and read ${snapshot!.value}');
    });
    super.initState();
    NotificationApi.init();
    getLocation(controller);
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  // Widget _infoTile(String title, String subtitle) {
  //   return ListTile(
  //     title: Text(title),
  //     subtitle: Text(subtitle.isEmpty ? 'Not set' : subtitle),
  //   );
  // }

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
                      _createHeader(),
                      // _createDrawerItem(
                      //   icon: Icons.contacts,
                      //   text: 'Contacts',
                      //   onTap: () {},
                      // ),
                      _createDrawerItem(
                        icon: Icons.event,
                        text: 'Events',
                      ),
                      _createDrawerItem(
                        icon: Icons.note,
                        text: 'Notes',
                      ),
                      const Divider(),
                      _createDrawerItem(
                          icon: Icons.stars,
                          text: 'Useful Links',),
                      const Divider(),
                      _createDrawerItem(
                          icon: Icons.bug_report,
                          text: 'Report an issue',),
                      ListTile(
                        title: Text('Ver: ${_packageInfo.version} / ${_packageInfo.buildNumber}'),
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
                body: getBody(),
              ),
      );

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Stack(children: <Widget>[
          Positioned(
            child: GestureDetector(
              onTap: () {
                Get.toNamed("/profile");
              },
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    // margin: EdgeInsets.all(20),
                    // padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2, color: Colors.white)),
                    child: CircleAvatar(
                      radius: 42,
                      child: Avatar(user: controller.firestoreUser.value!),
                    ),
                  )),
            ),
            top: 16,
            left: 16,
          ),
          Positioned(
            child: Text(controller.firestoreUser.value!.name),
            right: 16,
            top: 32,
          ),
          Positioned(
            child: Text(controller.firestoreUser.value!.email),
            right: 16,
            top: 48,
          ),
          Positioned(
            child: Text(locCnName),
            right: 16,
            top: 64,
          ),
          Positioned(
            child: Text(controller.firestoreUser.value!.post),
            right: 16,
            top: 80,
          ),
        ]));
  }

  Widget _createDrawerItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text!),
          )
        ],
      ),
      onTap: onTap,
    );
  }

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

  Future<String> getLocation(AuthController controller) async {
    final ref = FirebaseDatabase.instance.reference();

    return ref
        .child('location')
        .child(controller.firestoreUser.value!.cn)
        .once()
        .then((DataSnapshot snap) {
      final String locName = snap.value['name'].toString();
      if (locName != '') {
        setState(() {
          locCnName = locName;
        });
      }
      return locName;
    });
  }
}
