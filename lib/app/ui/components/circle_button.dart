import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final Color backColor, iconColor;
  final double iconSize;

  const CircleButton(
      {Key? key,
      required this.onTap,
      required this.backColor,
      required this.iconColor,
      required this.iconData,
      required this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 50.0;

    return InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
