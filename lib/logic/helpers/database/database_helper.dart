import 'dart:convert';
import 'dart:io' as IO;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'database_content.dart';

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

abstract class DatabaseHelper {
  Future<IO.File?> downloadFile(String url, String path);
  Future<List<DatabaseContent>> getDatabaseContent();
}

class DatabaseHelperEurope extends DatabaseHelper {
  DatabaseHelperEurope(this.code);

  //initializes the database
  static Database? _database;
  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  String code;
  String error = "";
  final String baseUrl = "https://ec.europa.eu/eurostat/api/dissemination";
  final dio = Dio();

  Future<Database> _initDatabase() async {
    var databasesPath = await getExternalStorageDirectory();
    var path = join(databasesPath!.path, "$code.csv");
    var exists = await databaseExists(path);

    if (!exists) {
      String url =
          "https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1/data/PRC_HICP_MIDX/.I15..$code?format=JSON&lang=en";
      try {
        downloadFile(url, databasesPath.path);
      } catch (e) {
        error = e.toString();
      }
    }

    return await openDatabase(path);
  }

  @override
  Future<IO.File?> downloadFile(String url, String path) async {
    final file = IO.File(join(path, "$code.csv"));

    return file;
  }

  @override
  Future<List<DatabaseContent>> getDatabaseContent() async {
    Database db = await database;
    var databaseContents = await db.rawQuery(
        "SELECT * FROM europe_price_index_all WHERE geo like 'DE' and coicop like 'CP00' and unit like 'I15';");
    List<DatabaseContent> databaseContentList = databaseContents.isNotEmpty
        ? databaseContents.map((e) => DatabaseContent.fromMap(e)).toList()
        : [];
    return databaseContentList;
  }
}
