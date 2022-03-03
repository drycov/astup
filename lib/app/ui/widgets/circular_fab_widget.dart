// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:math';

import 'package:flutter/material.dart';

const double buttonSize = 60;

class CircularFabWidget extends StatefulWidget {
  const CircularFabWidget({Key? key}) : super(key: key);

  @override
  State<CircularFabWidget> createState() => _CircularFabWidgetState();
}

class _CircularFabWidgetState extends State<CircularFabWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Flow(
        delegate: FlowMenuDelegate(animation: controller),
        children: <IconData>[
          Icons.qr_code_scanner_outlined,
          Icons.panorama_fish_eye_outlined,
          Icons.panorama_fish_eye_outlined,
          Icons.panorama_fish_eye_outlined,
          Icons.menu
        ].map<Widget>(buildFAB).toList(),
      );

  Widget buildFAB(IconData icon) => SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: FloatingActionButton(
          heroTag: null,
          elevation: 0,
          splashColor: Colors.black,
          child: Icon(icon, color: Colors.white, size: 45),
          onPressed: () {
            if (controller.status == AnimationStatus.completed) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
        ),
      );
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> animation;

  const FlowMenuDelegate({required this.animation}) : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - buttonSize;
    final yStart = size.height - buttonSize;
    final n = context.childCount;
    for (int i = 0; i < n; i++) {
      final isLastItem = i == context.childCount - 1;
      final setValue = (value) => isLastItem ? 0.0 : value;
      final radius = 120 * animation.value;
      final theta = i * pi * 0.5 / (n - 2);
      final x = xStart - setValue(radius * cos(theta));
      final y = yStart - setValue(radius * sin(theta));
      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(buttonSize / 2, buttonSize / 2)
            ..rotateZ(isLastItem ? 0.0 : 180 * (1 - animation.value) * pi / 180)
            ..scale(isLastItem ? 1.0 : max(animation.value, 0.5))
            ..translate(-buttonSize / 2, -buttonSize / 2));
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) => false;
}
