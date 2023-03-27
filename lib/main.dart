import 'package:flutter/material.dart';
import 'package:world_prices_app/logic/navigator/app_navigation.dart';
import 'package:world_prices_app/ui/nonreusable_widget//country_group/europe_group.dart';
import 'package:world_prices_app/logic/helpers/database/database_content.dart';
import 'package:world_prices_app/logic/helpers/database/database_helper.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("World Price App"),
      ),
      body: Column(children: [
        Expanded(
          child: CustomScrollView(
            cacheExtent: 500,
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
              const EuropeGroup(),
            ],
          ),
        ),
      ]),
    );
  }
}
