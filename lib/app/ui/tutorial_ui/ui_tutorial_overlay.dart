import 'package:flutter/material.dart';

class TutorialOverlay extends ModalRoute<void> {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.55);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const Positioned(
              bottom: 100,
              child: Text(
                'Result',
                style: TextStyle(fontSize: 24),
              )),
          const Positioned(
              bottom: 80,
              child: Text(
                'The result of scanning the QR code. When prompted, click.',
                style: TextStyle(fontSize: 14),
              )),
          Positioned(
              bottom: 14,
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  // color: const Color(0xff7c94b6),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              )),
          Positioned(
              top: 16,
              left: 18,
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  // color: const Color(0xff7c94b6),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              )),
          const Positioned(
              top: 80,
              left: 18,
              child: Text(
                'Camera \n control buttons',
                style: TextStyle(fontSize: 14),
              )),
          Positioned(
              top: 16,
              right: 18,
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  // color: const Color(0xff7c94b6),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              )),
          const Positioned(
              top: 80,
              right: 18,
              child: Text(
                'Additional functionality buttons',
                style: TextStyle(fontSize: 14),
              )),
          Positioned(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK. I reading'),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
