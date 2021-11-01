import 'package:astup/app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashUI extends StatefulWidget {
  const SplashUI({Key? key}) : super(key: key);

  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          child: Center(
              child: Container(
            child: CircularProgressIndicator(),
          )),
        ),
      );
}
