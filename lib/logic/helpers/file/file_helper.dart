import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileHelper {
  // FileHelper._privateConstructor();
  // static final FileHelper instance = FileHelper._privateConstructor();

  Future<bool> exists(String name) async {
    final privateStorage = await getExternalStorageDirectory();
    final filePath = "${privateStorage!.path}/$name";
    return File(filePath).exists();
  }

  Stream<bool> existsStream(String name) async* {
    final privateStorage = await getExternalStorageDirectory();
    final filePath = "${privateStorage!.path}/$name";
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield await File(filePath).exists();
    }
  }
}
