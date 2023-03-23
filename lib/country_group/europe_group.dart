import 'package:flutter/material.dart';
import 'package:world_prices_app/database/constants.dart';
import 'package:world_prices_app/database/database_content.dart';
import 'package:world_prices_app/database/database_helper.dart';

class EuropeGroup extends StatefulWidget {
  const EuropeGroup({super.key});
  @override
  State<EuropeGroup> createState() => _EuropeGroupState();
}

class _EuropeGroupState extends State<EuropeGroup> {
  SliverGridDelegate gridDelegate =
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
          addSemanticIndexes: true,
          childCount: europeCountries.length,
          (context, index) {
            String current = europeCountries[index];
            return Card(
              child: Text(europeEq[current]![0]),
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