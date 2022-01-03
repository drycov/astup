import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:astup/app/models/index.dart';

class DataRepository {
  // 1
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('locations');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  // 3
  Future<DocumentReference> addLocation(LocationModel loc) {
    return collection.add(loc.toJson());
  }
  // // 4
  // void updateLocations(LocationModel loc) async {
  //   await collection.doc(loc.referenceId).update(loc.toJson());
  // }
  // // 5
  // void deleteLocation(LocationModel loc) async {
  //   await collection.doc(loc.referenceId).delete();
  // }
}