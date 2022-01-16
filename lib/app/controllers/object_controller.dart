import 'dart:async';
import 'package:astup/app/helpers/helpers.dart';
import 'package:astup/app/models/index.dart';
import 'package:astup/app/ui/components/components.dart';
import 'package:astup/app/ui/index_ui.dart';
import 'package:astup/app/ui/ui_auth/ui_auth.dart';
import 'package:astup/app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ObjectController extends GetxController {
  static ObjectController to = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rxn<ObjectModel> object = Rxn<ObjectModel>();
  final String? result;

  ObjectController(this.result);
  //Streams the firestore user from the firestore collection
  Stream<ObjectModel> streamObject() {
    Globals.printMet('ObjectController.streamObject()');
    return _db
        .doc('/objects/${result}')
        .snapshots()
        .map((snapshot) => ObjectModel.fromMap(snapshot.data()!));
  }

  Future<ObjectModel> getUserLocation() {
    return _db.doc('/objects/${result}').get().then(
            (documentSnapshot) => ObjectModel.fromMap(documentSnapshot.data()!));
  }

}
