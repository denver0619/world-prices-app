import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:world_prices_app/database/database_content.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    /* Source
    * https://github.com/tekartik/sqflite/blob/master/sqflite/doc/opening_asset_db.md
    * */

    var databasesPath = await getExternalStorageDirectory();
    var path = join(databasesPath!.path, "europe_price_index_all.db");
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(
          "assets/datasets-uncompressed/europe/europe_price_index_all.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path, readOnly: true);
  }

  Future<List<DatabaseContent>> getDatabaseContent() async {
    Database db = await instance.database;
    var databaseContents = await db.rawQuery(
        "SELECT * FROM europe_price_index_all WHERE geo like 'DE' and coicop like 'CP00' and unit like 'I15';");
    List<DatabaseContent> databaseContentList = databaseContents.isNotEmpty
        ? databaseContents.map((e) => DatabaseContent.fromMap(e)).toList()
        : [];
    return databaseContentList;
  }
}
