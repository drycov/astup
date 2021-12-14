import 'package:flutter/material.dart';

class SplashUI extends StatefulWidget {
  const SplashUI({Key? key}) : super(key: key);

  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
            child: CircularProgressIndicator()),
      );
}
