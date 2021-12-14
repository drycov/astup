import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:path_provider/path_provider.dart';

class Api {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference? ref;

  Api(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref!.get(); //Futue Return single result over a period of time
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref!
        .snapshots(); // Stream Return multiple values over a period of time
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref!.doc(id).get();
  }

// Future<void> removeDocument(String id) {
//   return ref!.doc(id).delete();
// }
//
// Future<DocumentReference> addDocument(Map data) {
//   return ref!.add(data);
// }

// Future<void> updateDocument(Map mData, String id) {
//   return ref!.doc(id).update(mData);
// }
}

class FileApi {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  firebase_storage.Reference? ref;
  final String path;

  FileApi(this.path) {
    ref = _storage.ref(path);
  }

  Future<String?> downloadURL() async {
    return await ref!.getDownloadURL();
  }

  Future<void> uploadExample(String filePath) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    filePath = '${appDocDir.absolute}/file-to-upload.png';
  }

  Future<void> uploadFileWithMetadata(
      String filePath, String uid, String authorName, String path) async {
    File file = File(filePath);

    // Create your custom metadata.
    firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(
      cacheControl: 'max-age=60',
      customMetadata: <String, String>{
        'userId': uid,
        'authorName': authorName,
      },
    );

    try {
      // Pass metadata to any file upload method e.g putFile.
      await firebase_storage.FirebaseStorage.instance
          .ref(path)
          .putFile(file, metadata);
    } on firebase_core.FirebaseException catch (e) {
      print(e.code.toString());
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> downloadFileExample(String path, String fileName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/${fileName}}');

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('${path}/${fileName}')
          .writeToFile(downloadToFile);
    } on firebase_core.FirebaseException catch (e) {
      print(e.code.toString());
      // e.g, e.code == 'canceled'
    }
  }
// firebase_storage.Reference ref =
// firebase_storage.FirebaseStorage.instance.ref('/notes.txt');

}
