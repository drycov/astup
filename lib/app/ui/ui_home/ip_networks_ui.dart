import 'package:flutter/material.dart';

class IPUI extends StatefulWidget {
  const IPUI({Key? key}) : super(key: key);

  @override
  _IPUIState createState() => _IPUIState();
}

class _IPUIState extends State<IPUI> {
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
        child: CircularProgressIndicator()),
  );
}
