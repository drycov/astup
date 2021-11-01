import 'package:astup/app/models/models.dart';
import 'package:astup/app/ui/components/components.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';


class Avatar extends StatelessWidget {
  Avatar(
    this.user,
  );
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    if (user.photoUrl == ''&&user.name == '') {
      return LogoGraphicHeader();
    }else if(user.photoUrl == ''&&user.name != ''){
      return Hero(
        tag: 'User Avatar Image',
        child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 70.0,
            child: ClipOval(
              child: TextAvatar(
                shape: Shape.Circular,
                size: 120,
                textColor: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w600,
                upperCase: true,
                backgroundColor: Colors.black,
                numberLetters: 2,
                text: user.name,
              )
            )),
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
