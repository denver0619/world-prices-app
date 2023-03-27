import 'package:flutter/material.dart';
import 'package:world_prices_app/logic/helpers/database/database_content.dart';
import 'package:world_prices_app/logic/helpers/database/database_helper.dart';
import 'package:world_prices_app/ui/reusable_widget/loading_sliver.dart';

class EuropeCountry extends StatefulWidget {
  const EuropeCountry({Key? key, required this.title, required this.code})
      : super(key: key);
  final String title;
  final String code;

  @override
  State<EuropeCountry> createState() => _EuropeCountryState();
}

class _EuropeCountryState extends State<EuropeCountry> {
  @override
  Widget build(BuildContext context) {
    DatabaseHelperEurope database = DatabaseHelperEurope(widget.code);

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
                // FutureBuilder<List<DatabaseContent>>(
                //   future: database.getDatabaseContent(),
                //   builder: (context, snapshot) {
                //     return const LoadingSliver();
                // },)
              ],
            ),
          )
        ],
      ),
    );
  }
}
