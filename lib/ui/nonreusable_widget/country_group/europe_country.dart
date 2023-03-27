import 'package:flutter/material.dart';
import 'package:world_prices_app/logic/helpers/database/database_content.dart';
import 'package:world_prices_app/logic/helpers/database/database_helper.dart';
import 'package:world_prices_app/ui/reusable_widget/loading_sliver.dart';

import '../../../constants.dart';

class EuropeCountry extends StatefulWidget {
  const EuropeCountry({Key? key, required this.title, required this.code})
      : super(key: key);
  final String title;
  final String code;

  @override
  State<EuropeCountry> createState() => _EuropeCountryState();
}

class _EuropeCountryState extends State<EuropeCountry> {
  late Future<List<DatabaseContent>> databaseContent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseContent = DatabaseHelperEurope.instance
        .getDatabaseContent(widget.code, europeEq[widget.code]![2]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 1,
                    (context, index) {
                      return Text(
                          "This page contains the information about ${widget.title}");
                    },
                  ),
                ),
                // SliverGrid(
                //     delegate: SliverChildBuilderDelegate(
                //       childCount: 2,
                //       (context, index) {
                //         return Row(
                //           children: [],
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //         );
                //       },
                //     ),
                //     gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 2)),
                FutureBuilder(
                    future: databaseContent,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            childCount: snapshot.data!.length,
                            (context, index) {
                              return Card(
                                child: Wrap(
                                  children: [
                                    Text(snapshot.data![index].last_update),
                                    Text(snapshot.data![index].dataflow),
                                    Text(snapshot.data![index].freq),
                                    Text(snapshot.data![index].unit),
                                    Text(snapshot.data![index].coicop),
                                    Text(snapshot.data![index].time_period),
                                    Text(snapshot.data![index].geo),
                                    Text(snapshot.data![index].obs_value),
                                    Text(snapshot.data![index].obs_flag),
                                  ],
                                ),
                              );
                            },
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                        );
                      } else {
                        return SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            childCount: 1,
                            (context, index) {
                              return Wrap(
                                children: const [
                                  CircularProgressIndicator(),
                                  Text("Loading Database"),
                                ],
                              );
                            },
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                        );
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
