import 'package:astup/app/controllers/controllers.dart';
import 'package:astup/app/res/colors.dart';
import 'package:astup/app/ui/components/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
final AuthController authController = AuthController.to;

class ChatScreen extends StatefulWidget {
  static String id = "Chatscreen";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextEditingController = TextEditingController();
  late ScrollController _scroll;
  final FocusNode _focus = new FocusNode();
  String message = "";

  // User? loggedInUser = auth.currentUser;
  // Color textColor = AppThemesColors.white;
  // Color BGcolor = AppThemesColors.white;
  // Color ACcolor = AppThemesColors.dodgerBlue;
  // Color ACcolor2 = AppThemesColors.laPalma;

  @override
  void initState() {
    _scroll = new ScrollController();
    _focus.addListener(() {
      _scroll.jumpTo(-1.0);
    });
    super.initState();
    // loggedInUser = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Get.back();
            }),
        actionsIconTheme: const IconThemeData(),
        title: Text('report.title'.tr),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessagesStream(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: TextField(
                      focusNode: _focus,
                      minLines: 1,
                      maxLines: 10,
                      maxLength: 500,
                      style: const TextStyle(color: AppThemesColors.white),
                      onChanged: (str) {
                        message = str;
                      },
                      controller: messageTextEditingController,
                      cursorColor: AppThemesColors.white,
                      cursorHeight: 24,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(500),
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                                color: AppThemesColors.white, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                                color: AppThemesColors.white, width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                                color: AppThemesColors.white, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                                color: AppThemesColors.white, width: 1),
                          ),
                          filled: true,
                          labelStyle: TextStyle(color: AppThemesColors.white),
                          fillColor: AppThemesColors.dimGray,
                          hintText: 'say something...',
                          hintStyle: TextStyle(
                            color: AppThemesColors.white,
                          )),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 16, 24),
                    child: CircleAvatar(
                      child: IconButton(
                        onPressed: () {
                          // function when send button is pressed
                          var now = DateTime.now();
                          // print("send button pressed");
                          // print(message);
                          messageTextEditingController.clear();
                          firestore.collection('bugReport').add({
                            'sender': authController.firestoreUser.value!.email,
                            'uname': authController
                                    .firestoreUser.value!.firstName +
                                " " +
                                authController.firestoreUser.value!.lastName,
                            'text': message,
                            'time': now.year.toString() +
                                "-" +
                                now.month.toString() +
                                "-" +
                                now.day.toString() +
                                "-" +
                                now.hour.toString() +
                                "-" +
                                now.minute.toString() +
                                "-" +
                                now.second.toString()
                          });
                        },
                        icon: const Icon(Icons.send_rounded),
                        color: AppThemesColors.white,
                        iconSize: 30,
                      ),
                      backgroundColor: AppThemesColors.dimGray,
                      radius: 25,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('bugReport').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<messageBubble> messageWidgets = [];
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final messageUname = message.get('uname');
          final MessageBubble = messageBubble(
            senderFML: messageUname,
            sender: messageSender,
            text: messageText,
            isME: authController.firestoreUser.value!.email == messageSender,
          );
          messageWidgets.add(MessageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageWidgets,
          ),
        );
      },
    );
    // return StreamBuilder<QuerySnapshot>(
    //   stream: firestore.collection('bugReport').orderBy("time").snapshots(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return const Center(
    //         child: CircularProgressIndicator(
    //           backgroundColor: Colors.lightBlueAccent,
    //         ),
    //       );
    //     }
    //     final messages = snapshot.data!.docs.reversed;
    //     List<ChatBubble> messageBubbles = [];
    //     for (var message in messages) {
    //       final messageSender = message.get('sender');
    //       final messageText = message.get('text');
    //       final currentUser = auth.currentUser?.email;
    //
    //       final messageBubble = ChatBubble(
    //           messageSender, messageText, currentUser != messageSender);
    //
    //       messageBubbles.add(messageBubble);
    //     }
    //     return Expanded(
    //       child: ListView(
    //         reverse: true,
    //         padding:
    //             const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
    //         children: messageBubbles,
    //       ),
    //     );
    //   },
    // );
  }
}
