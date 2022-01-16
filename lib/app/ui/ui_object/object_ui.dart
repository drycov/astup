import 'package:astup/app/controllers/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ObjectUi extends StatefulWidget {
  const ObjectUi({Key? key}) : super(key: key);

  @override
  _ObjectUiState createState() => _ObjectUiState();
}

class _ObjectUiState extends State<ObjectUi> {
  String result = "0000";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String? _result = Get.parameters['result'];
    result = _result!;
  }

  Widget build(BuildContext context) => FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('/objects').doc(result).get(),
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
            return GetBuilder<ObjectController>(
              init: ObjectController(),
              builder: (controller) => result == null
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
                              onTap: () {
                                Get.toNamed('/chat');
                              },
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
                              onTap: () {
                                Get.toNamed('/report');
                              },
                            ),
                            const Divider(),
                            ListTile(
                              title: Text(
                                  'Ver: ${_packageInfo.version} / ${_packageInfo.buildNumber}'),
                            ),
                          ],
                        ),
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
                        // BottomNavigationBarItem(
                        //   icon: Icon(Icons.alt_route_outlined),
                        //   label: "IP Networks",
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
        },
      );

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actionsIconTheme: const IconThemeData(
              color: Colors.white,
            ),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                onPressed: () {
                  Get.back();
                }),
            title: Text('object.title'.tr + ' : ' + result),
          ),
          body: Stack(alignment: Alignment.center, children: <Widget>[
            Positioned(top: 0, left: 6, right: 6, child: objectImage(context)),
            Positioned(
                bottom: 0,
                left: 6,
                right: 6,
                child: objectDescription(context)),
          ])));

  Widget objectImage(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8))),
      child: Image.network(
        "https://eltex-co.ru/upload/resize_cache/iblock/3ea/250_250_0/MES2324.png",
        fit: BoxFit.contain,
        width: MediaQuery.of(context).size.width,
        height: 240,
      ),
    );
  }

  Widget objectDescription(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 360,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8))),
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    result,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.sn'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    '22O34F50000450',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.comson'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    '25.06.2019',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.liab'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'Rykov D. I.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.model'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'MES2324',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.ip'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    '10.145.3.103',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.type'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'Network switch',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.location'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'Buhtarma',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.sysName'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'SNP250_Akimat',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.role'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'access',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.position'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'ВКО, ',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 72,
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffC4C4C4)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(children: [
                        Icon(Icons.wb_iridescent_outlined),
                        Text("object.title.vlan".tr)
                      ]),
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffC4C4C4)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(children: [
                        Icon(Icons.settings_input_hdmi_outlined),
                        Text("object.title.port".tr)
                      ]),
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffC4C4C4)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        var data = {"result": '${result}'};
                        Get.offNamed('/timeline', parameters: data);
                      },
                      child: Row(children: [
                        Icon(Icons.history_edu_outlined),
                        Text("object.title.timeline".tr)
                      ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
// bodyObject(result, context)
