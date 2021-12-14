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
  Widget build(BuildContext context) => Scaffold(
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
        title: Text('object.title'.tr + ' ' + result),
      ),
      body: Container(
        child: Text(result),
      ));
}
