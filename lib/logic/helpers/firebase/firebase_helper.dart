import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageHelper {
  FirebaseStorageHelper._privateConstructor();
  static final FirebaseStorageHelper instance = FirebaseStorageHelper._privateConstructor();

  final String gsBucket = "gs://world-price-app.appspot.com/";
  final storageRef = FirebaseStorage.instance.ref();



  Future<String> downloadUrl(String refPath) async {
    final pathRef = storageRef.child(refPath);
    // final file = File(filePath);
    return await pathRef.getDownloadURL();
  }
}
