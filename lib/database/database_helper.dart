import 'dart:io' as IO;
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<List<String>> getCountries(String txt);
}

class DatabaseHelperEurope extends DatabaseHelper {
  // //creates a private instance of this class
  DatabaseHelperEurope._privateConstructor();
  static final DatabaseHelperEurope instance =
      DatabaseHelperEurope._privateConstructor();

  //initializes the database
  static Database? _database;
  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  String error = "No errors";
  final String baseUrl = "https://ec.europa.eu/eurostat/api/dissemination";
  final dio = Dio();

  Future<Database> _initDatabase() async {
    var databasesPath = await getExternalStorageDirectory();
    var path = join(databasesPath!.path, "prc_hicp_midx_linear.db");
    var exists = await databaseExists(path);

    if (!exists) {
      String url =
          "https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1/data/PRC_HICP_MIDX?format=SDMX-CSV";
      try {
        downloadFile(url, databasesPath!.path);
      } catch (e) {
        error = e.toString();
      }
    }

    return await openDatabase(path);
  }

  @override
  Future<IO.File?> downloadFile(String url, String path) async {
    final file = IO.File(join(path, "prc_hicp_midx_linear.db"));

    final response = await Dio().get(url);

    final raf = file.openSync(mode: IO.FileMode.write);
    raf.writeByteSync(response.data);
    await raf.close();

    return file;
  }

  @override
  Future<List<String>> getCountries(String txt) async {
    final response = await dio.fetch(
      RequestOptions(
        baseUrl: baseUrl,
      ),
    );
    return [];
  }
}
