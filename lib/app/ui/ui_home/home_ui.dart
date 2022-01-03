// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:astup/app/controllers/controllers.dart';
import 'package:astup/app/helpers/notification_api.dart';
import 'package:astup/app/res/colors.dart';
import 'package:astup/app/res/index.dart';
import 'package:astup/app/ui/components/index.dart';
import 'package:astup/app/ui/index_ui.dart';
import 'package:astup/app/ui/ui_home/index_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
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
  int selectedIndex = 0;
  final Widget _sysVlanUI = const VlanUI();
  final Widget _myIpUI = const IPUI();
  final AuthController controller = AuthController.to;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('/locations')
            .doc(controller.firestoreUser.value!.cn.toString())
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return GetBuilder<AuthController>(
              init: AuthController(),
              builder: (controller) => controller.firestoreUser.value!.uid ==
                      null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Scaffold(
                      appBar: AppBar(
                        actionsIconTheme: const IconThemeData(),
                        title: Text('home.title'.tr),
                        actions: [
                          IconButton(
                              icon: const Icon(Icons.qr_code_scanner_outlined),
                              onPressed: () {
                                Get.toNamed('/qrview');
                              }),
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
                            _createHeader(data),
                            _createDrawerItem(
                              icon: Icons.description_outlined,
                              text: 'Tasks',
                              onTap: () {},
                            ),
                            _createDrawerItem(
                              icon: Icons.question_answer_outlined,
                              text: 'Messages',
                              onTap: () {Get.toNamed('/chat');},
                            ),
                            const Divider(),
                            _createDrawerItem(
                              icon: Icons.storage_outlined,
                              text: 'My objects',
                              onTap: () {},
                            ),
                            _createDrawerItem(
                              icon: Icons.settings_input_component_outlined,
                              text: 'Fiber revision',
                              onTap: () {},
                            ),
                            const Divider(),
                            _createDrawerItem(
                              icon: Icons.pest_control_outlined,
                              text: 'Report an issue',
                              onTap: () {Get.toNamed('/report');},
                            ),
                            const Divider(),
                            ListTile(
                              title: Text(
                                  'Ver: ${_packageInfo.version} / ${_packageInfo.buildNumber}'),
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
                          // BottomNavigationBarItem(
                          //   icon: Icon(Icons.alt_route_outlined),
                          //   label: "IP Networks",
                          //
                          // ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.history_edu_outlined),
                            label: "History request",
                          )
                        ],
                        onTap: (int index) {
                          onTapHandler(index);
                        },
                      ),
                      body: getBody(),
                    ),
            );
          }
          return GetBuilder<AuthController>(
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
                            icon: const Icon(Icons.qr_code_scanner_outlined),
                            onPressed: () {
                              Get.toNamed('/qrview');
                            }),
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
                          // _createHeader(data),
                          CircularProgressIndicator(),
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
                            text: 'Useful Links',
                          ),
                          const Divider(),
                          _createDrawerItem(
                            icon: Icons.bug_report,
                            text: 'Report an issue',
                          ),
                          ListTile(
                            title: Text(
                                'Ver: ${_packageInfo.version} / ${_packageInfo.buildNumber}'),
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
        },
      );

  Widget _createHeader(Map<String, dynamic> data) {
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
            child: Text(
              controller.firestoreUser.value!.name.toString(),
              style: const TextStyle(color: AppThemesColors.white),
            ),
            right: 16,
            top: 32,
          ),
          Positioned(
            child: Text(
              controller.firestoreUser.value!.email.toString(),
              style: const TextStyle(color: AppThemesColors.white),
            ),
            right: 16,
            top: 48,
          ),
          Positioned(
            child: Text(
              '${data['on']}',
              style: const TextStyle(color: AppThemesColors.white),
            ),
            right: 16,
            top: 64,
          ),
          Positioned(
            child: Text(
              controller.firestoreUser.value!.post.toString(),
              style: const TextStyle(color: AppThemesColors.white),
            ),
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
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
