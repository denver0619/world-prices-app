import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'World Price Index'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Database> textDB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textDB = loadDataBase();
  }

  Future<Database> loadDataBase() async {
    return await openDatabase('assets/datasets-uncompressed/europe/europe_price_index_all.sql3');;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: textDB,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
