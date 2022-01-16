import 'package:astup/app/ui/components/components.dart';
import 'package:astup/app/ui/index_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:timelines/timelines.dart';

class TimelineUI extends StatefulWidget {
  const TimelineUI({Key? key}) : super(key: key);

  @override
  _TimelineUIState createState() => _TimelineUIState();
}

class _TimelineUIState extends State<TimelineUI> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // actionsIconTheme: const IconThemeData(),
          title: Text('timeline.title'.tr),
          actionsIconTheme: const IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                Get.back();
              }),
          actions: [
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Get.to(const SettingsUI());
                }),
          ],
        ),
        body: Center(
          child: Timeline(
            children: <Widget>[
              Container(height: 100, color: Colors.red),
              Container(height: 50, color: Colors.green),
              Container(height: 200, color: Colors.amber),
              Container(height: 100, color: Colors.blue),
            ],
            indicators: const <Widget>[
              Icon(Icons.access_alarm),
              Icon(Icons.backup),
              Icon(Icons.accessibility_new),
              Icon(Icons.access_alarm),
            ],
          ),
        ),
      );
}
