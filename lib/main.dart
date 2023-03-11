import 'package:flutter/material.dart';
import 'package:world_prices_app/country_group/europe_group.dart';
import 'package:world_prices_app/database/database_content.dart';
import 'package:world_prices_app/database/database_helper.dart';
import 'package:world_prices_app/loading_sliver.dart';

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
  late Future<List<DatabaseContent>> europe;

  @override
  void initState() {
    super.initState();
    europe = DatabaseHelper.instance.getDatabaseContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  addAutomaticKeepAlives: true,
                  addRepaintBoundaries: true,
                  addSemanticIndexes: true,
                  childCount: 1,
                  (context, index) => const Text("Europe"),
                ),
              ),
              FutureBuilder(
                future: europe,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    debugPrint(
                        "!!!!! snapshot length: ${snapshot.data!.length}");
                    return EuropeGroup(data: snapshot.data!);
                  } else {
                    return const LoadingSliver();
                  }
                },
              )
            ],
          ),
        ),
      ]),
    );
  }
}
