import 'dart:async';

import 'package:astup/app/controllers/auth_controller.dart';
import 'package:astup/app/controllers/controllers.dart';
import 'package:astup/app/ui/components/logo_graphic_header.dart';
import 'package:astup/app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUI extends StatefulWidget {
  const ProfileUI({Key? key}) : super(key: key);

  @override
  _ProfileUIState createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  late DatabaseReference _dbRef;
  late StreamSubscription<Event> _locationSubscription;
  final AuthController authController = AuthController.to;
  String locCnName = '';

  // CollectionReference locations =
  //     FirebaseFirestore.instance.collection('locations');

  @override
  void initState() {
    super.initState();
    // Demonstrates configuring to the database using a file
    _dbRef = FirebaseDatabase.instance.reference();
    // Demonstrates configuring the database directly
    final FirebaseDatabase database = FirebaseDatabase();
    database.reference().child('location').get().then((DataSnapshot? snapshot) {
      // print(
      // 'Connected to directly configured database and read ${snapshot!.value}');
    });

    if (!kIsWeb) {
      database.setPersistenceEnabled(true);
      database.setPersistenceCacheSizeBytes(10000000);
      _dbRef.keepSynced(true);
    }

    _locationSubscription =
        _dbRef.limitToLast(10).onChildAdded.listen((Event event) {
      // print('Child added: ${event.snapshot.value}');
    }, onError: (Object o) {
      // final DatabaseError error = o as DatabaseError;
      // print('Error: ${error.code} ${error.message}');
    });
    getLocation();
  }

  @override
  void dispose() {
    super.dispose();
    _locationSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    authController.cnController.text = authController.firestoreUser.value!.cn;
    authController.postController.text =
        authController.firestoreUser.value!.post;
    authController.firstNameController.text =
        authController.firestoreUser.value!.firstName;
    authController.middleNameController.text =
        authController.firestoreUser.value!.middleName;
    authController.lastNameController.text =
        authController.firestoreUser.value!.lastName;
    readData();
    return Scaffold(
        appBar: AppBar(
          title: Text('auth.profileTitle'.tr),
          actionsIconTheme: const IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                Get.back();
              }),
        ),
        body: StreamBuilder(
            // stream: locations.orderBy(locId).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return _buildLayoutSection(context, snapshot);
        }));
  }

  Widget _buildLayoutSection(BuildContext context, snapshot) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 8.0),

                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      // margin: EdgeInsets.all(20),
                      // padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2, color: Theme.of(context).colorScheme.primary,)),
                      child: CircleAvatar(
                        radius: 42,
                        child: LogoGraphicHeader(
                          avatar: authController.firestoreUser.value!.fileName,
                        ),
                      ),
                    )),
                // LogoGraphicHeader(
                //   avatar: authController.firestoreUser.value!.photoUrl,
                // ),
                const SizedBox(height: 16.0),
                Text(
                  authController.firestoreUser.value!.name,
                  style: const TextStyle(color: AppThemes.black, fontSize: 24),
                ),
                const SizedBox(height: 48.0),
              ],
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'auth.emailFormField'.tr,
              style: const TextStyle(color: AppThemes.black, fontSize: 16),
            ),
            Text(
              authController.firestoreUser.value!.email,
              style: const TextStyle(color: AppThemes.black, fontSize: 16),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'auth.cnFormField'.tr,
              style: const TextStyle(color: AppThemes.black, fontSize: 16),
            ),
            Text(
              locCnName,
              style: const TextStyle(color: AppThemes.black, fontSize: 16),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'auth.postFormField'.tr,
              style: const TextStyle(color: AppThemes.black, fontSize: 16),
            ),
            Text(
              authController.firestoreUser.value!.post,
              style: const TextStyle(color: AppThemes.black, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  void readData() {
    _dbRef.once().then((DataSnapshot snapshot) {
      // print('Data : ${snapshot.value}');
    });
  }

  Future<String> getLocation() async {
    final ref = FirebaseDatabase.instance.reference();

    return ref
        .child('location')
        .child(authController.firestoreUser.value!.cn)
        .once()
        .then((DataSnapshot snap) {
      final String locName = snap.value['name'].toString();
      // print(locName);
      if (locName != '') {
        setState(() {
          locCnName = locName;
        });
      }
      return locName;
    });
  }
}
