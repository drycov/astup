import 'package:flutter/material.dart';
import 'package:loading/loading.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Loading( size: 100.0, color: Colors.white),
        ),
      ),
    );
  }
}