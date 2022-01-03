import 'package:astup/app/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldCust extends StatefulWidget {
  String label;
  void Function(String str) textChange;

  TextFieldCust({Key? key, required this.label, required this.textChange}) : super(key: key);

  @override
  _TextFieldCustState createState() => _TextFieldCustState();
}

class _TextFieldCustState extends State<TextFieldCust> {
  Color textColor = AppThemesColors.white;
  Color BGcolor = AppThemesColors.white;
  Color ACcolor = AppThemesColors.dodgerBlue;
  Color ACcolor2 = AppThemesColors.laPalma;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        onChanged: widget.textChange,
        style: TextStyle(color: textColor),
        cursorColor: textColor,
        cursorHeight: 25,
        decoration: InputDecoration(
          labelText: widget.label,
          focusColor: ACcolor,
          labelStyle: TextStyle(
              color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: textColor, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: textColor, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: textColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: textColor, width: 2),
          ),
          filled: true,
          fillColor: ACcolor,
        ),
      ),
    );
  }
}
