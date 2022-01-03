import 'package:astup/app/models/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'controllers.dart';

class VlanController extends GetxController {
  static VlanController to = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rxn<VlanModel> vlans = Rxn<VlanModel>();
  final AuthController authController = AuthController.to;

  //Streams the firestore user from the firestore collection
  Stream<VlanModel> streamVlan() {
    return _db
        .doc('/vlans/${authController.cnController.value}')
        .snapshots()
        .map((snapshot) => VlanModel.fromMap(snapshot.data()!));
  }
}
