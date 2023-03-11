import 'package:flutter/material.dart';
import 'package:world_prices_app/database/database_content.dart';
import 'package:world_prices_app/database/database_helper.dart';

class EuropeGroup extends StatefulWidget {
  final List<DatabaseContent> data;
  const EuropeGroup({super.key, required this.data});
  @override
  State<EuropeGroup> createState() => _EuropeGroupState();
}

class _EuropeGroupState extends State<EuropeGroup> {
  SliverGridDelegate gridDelegate =
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);

  int _childCount = 0;

  @override
  void initState() {
    super.initState();
    _childCount = widget.data.length;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("!!!!! child Length: $_childCount");
    debugPrint("!!!!! data Length: ${widget.data.length}");
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
          addSemanticIndexes: true,
          childCount: _childCount,
          (context, index) {
            DatabaseContent current = widget.data[index];
            debugPrint("$index");
            return Card(
              child: Text("${current.last_update} "
                  "${current.geo} "
                  "${current.time_period} "
                  "${current.obs_value} "
                  "${current.obs_flag} "),
            );
          },
        ),
        gridDelegate: gridDelegate);
  }
}



// FutureBuilder<List<DatabaseContent>>(
//           future: DatabaseHelper.instance.getDatabaseContent(),
//           builder: (context, AsyncSnapshot<List<DatabaseContent>> snapshot) {
//             debugPrint("!!!!! "+"Snapshot has data ? " + snapshot.hasData.toString());
//             if (snapshot.hasData) {
//               return ListView(
//                 children: snapshot.data!.map((contents) {
//                   return ListTile(
//                     title: Text("${contents.last_update} "
//                         "${contents.geo} "
//                         "${contents.time_period} "
//                         "${contents.obs_value} "
//                         "${contents.obs_flag} "),
//                   );
//                 }).toList(),
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ),