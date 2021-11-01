import 'package:astup/app/models/models.dart';
import 'package:astup/app/ui/components/components.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.user})
      : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    double avaRadius;
    if (user.photoUrl == '' && user.name == '') {
      return LogoGraphicHeader();
    } else if (user.photoUrl == '' && user.name != '') {
    
      return Hero(
        tag: 'User Avatar Image',
        child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 70,
            child: ClipOval(
                child: TextAvatar(
              shape: Shape.Circular,
              size: 65,
              textColor: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w600,
              upperCase: true,
              backgroundColor: Colors.black,
              numberLetters: 2,
              text: user.name,
            ))),
      );
    }
    return Hero(
      tag: 'User Avatar Image',
      child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 70.0,
          child: ClipOval(
            child: Image.network(
              user.photoUrl,
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );
  }
}
