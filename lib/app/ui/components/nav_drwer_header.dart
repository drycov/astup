import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';

final uiDrawerHeader = DrawerHeader(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      CircleAvatar(
        radius: 40,
        child: ClipOval(
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        'Ehmad Saeed',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      Text(
        'justehmadsaeed@gmail.com',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    ],
  ),
  decoration: BoxDecoration(color: Colors.teal[800]),
);