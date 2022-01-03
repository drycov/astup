import 'package:astup/app/res/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  String user;
  String Message;
  bool others;

  ChatBubble(this.user, this.Message, this.others, {Key? key})
      : super(key: key);

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  Color textColor = AppThemesColors.white;
  Color BGcolor = AppThemesColors.white;
  Color ACcolor = AppThemesColors.dodgerBlue;
  Color ACcolor2 = AppThemesColors.laPalma;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            widget.others ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            widget.user,
            style: TextStyle(fontSize: 14),
          ),
          Material(
            elevation: 10,
            borderRadius: widget.others
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
            color: widget.others ? textColor : ACcolor2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                widget.Message,
                style: TextStyle(
                    fontSize: 20, color: widget.others ? ACcolor2 : BGcolor),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class messageBubble extends StatelessWidget {
  final String sender, senderFML, text;
  bool isME;

  Color messageColor() {
    if (isME) {
      return AppThemesColors.forestGreen;
    } else {
      return AppThemesColors.brinkPink;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment:
            isME ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              '$senderFML',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          Material(
              elevation: 5,
              borderRadius: isME
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))
                  : const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
              color: messageColor(),
              child: Padding(
                padding: EdgeInsets.all(8),
                // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  '$text',
                  style: TextStyle(
                      fontSize: 20,
                      color: isME ? Colors.white : AppThemesColors.whiteLilac),
                ),
              )),
        ],
      ),
    );
  }

  messageBubble(
      {required this.sender,
      required this.senderFML,
      required this.text,
      required this.isME});
}
