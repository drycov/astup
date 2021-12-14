import 'package:flutter/material.dart';

class TimelineUI extends StatefulWidget {
  const TimelineUI({Key? key}) : super(key: key);

  @override
  _TimelineUIState createState() => _TimelineUIState();
}

class _TimelineUIState extends State<TimelineUI> {
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
        child: CircularProgressIndicator()),
  );
}
