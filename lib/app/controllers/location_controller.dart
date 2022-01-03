import 'package:astup/app/models/index.dart';
import 'package:astup/app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'controllers.dart';

class LocationController extends GetxController {
  static LocationController to = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthController authController = AuthController.to;
  Rxn<LocationModel> muserLocation = Rxn<LocationModel>();
  Stream<LocationModel> streamLocation() {
    Globals.printMet('streamFirestoreUser()');
    return _db
        .doc('/locations/${authController.firestoreUser.value!.cn.toString()}')
        .snapshots()
        .map((snapshot) => LocationModel.fromMap(snapshot.data()!));
  }

  Future<LocationModel> getUserLocation() {
    return _db.doc('/locations/${authController.firestoreUser.value!.cn.toString()}').get().then(
            (documentSnapshot) => LocationModel.fromMap(documentSnapshot.data()!));
  }
}
