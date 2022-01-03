import 'package:flutter/material.dart';

class VlanUI extends StatefulWidget {
  const VlanUI({Key? key}) : super(key: key);

  @override
  _VlanUIState createState() => _VlanUIState();
}

class _VlanUIState extends State<VlanUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
