import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_content.dart';
import 'package:path/path.dart';

// class DatabaseHelper {
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//
//   static Database? _database;
//   Future<Database> get database async {
//     return _database ??= await _initDatabase();
//   }
//
//   Future<Database> _initDatabase() async {
//     /* Source
//     * https://github.com/tekartik/sqflite/blob/master/sqflite/doc/opening_asset_db.md
//     * */
//
//     var databasesPath = await getExternalStorageDirectory();
//     var path = join(databasesPath!.path, "europe_price_index_all.db");
//     var exists = await databaseExists(path);
//
//     if (!exists) {
//       try {
//         await Directory(dirname(path)).create(recursive: true);
//       } catch (_) {}
//
//       ByteData data = await rootBundle.load(
//           "assets/datasets-uncompressed/europe/europe_price_index_all.db");
//       List<int> bytes =
//           data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//
//       await File(path).writeAsBytes(bytes, flush: true);
//     }
//     return await openDatabase(path, readOnly: true);
//   }
//
//   Future<List<DatabaseContent>> getDatabaseContent() async {
//     Database db = await instance.database;
//     var databaseContents = await db.rawQuery(
//         "SELECT * FROM europe_price_index_all WHERE geo like 'DE' and coicop like 'CP00' and unit like 'I15';");
//     List<DatabaseContent> databaseContentList = databaseContents.isNotEmpty
//         ? databaseContents.map((e) => DatabaseContent.fromMap(e)).toList()
//         : [];
//     return databaseContentList;
//   }
// }

class DatabaseHelperEurope{
  DatabaseHelperEurope._privateConstructor();
  static final DatabaseHelperEurope instance = DatabaseHelperEurope._privateConstructor();

  //initializes the database
  // static Database? _database;
  Future<Database> getDatabase (String fileName)async {
    return await initDatabase(fileName);
  }

  // String code;
  // String name;
  // String error = "";

  ///file name of the db
  Future<Database> initDatabase(String fileName) async {
    var databasesPath = await getExternalStorageDirectory();
    var path = join(databasesPath!.path, fileName);
    return await openDatabase(path, readOnly: true);
  }

  ///alpha-2code
  Future<bool> check(String code, String fileName) async {
    var db = await getDatabase(fileName);
    List<Map<String, Object?>> databaseContents;
    try {
      databaseContents = await db.rawQuery("select COUNT(*) from ${code}_INDEX");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<DatabaseContent>> getDatabaseContent(String code, String fileName) async {
    Database db = await getDatabase(fileName);
    var databaseContents = await db.rawQuery(
        "SELECT * FROM ${code}_INDEX");
    List<DatabaseContent> databaseContentList = databaseContents.isNotEmpty
        ? databaseContents.map((e) => DatabaseContent.fromMap(e)).toList()
        : [];
    return databaseContentList;
  }
}
