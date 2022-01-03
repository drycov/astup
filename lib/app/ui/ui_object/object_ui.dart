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
            // actions: <Widget>[
            //   IconButton(
            //       icon: Icon(Icons.info_outlined),
            //       onPressed: () => {
            //         print("Click on settings button")
            //       }
            //   ),
            // ],
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
      decoration: BoxDecoration(
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
        decoration: BoxDecoration(
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
              SizedBox(
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
              SizedBox(
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
                      onPressed: () {},
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
