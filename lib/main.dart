import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';
import 'package:world_prices_app/DatabaseContent.dart';
import 'package:world_prices_app/DatabaseHelper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<DatabaseContent>>(
          future: DatabaseHelper.instance.getDatabaseContent(),
          builder: (context, AsyncSnapshot<List<DatabaseContent>> snapshot) {
            debugPrint("!!!!! "+"Snapshot has data ? " + snapshot.hasData.toString());
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.map((contents) {
                  return ListTile(
                    title: Text("${contents.last_update} "
                        "${contents.geo} "
                        "${contents.time_period} "
                        "${contents.obs_value} "
                        "${contents.obs_flag} "),
                  );
                }).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
