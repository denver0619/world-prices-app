import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:world_prices_app/constants.dart';
import 'package:world_prices_app/logic/helpers/database/database_helper.dart';
import 'package:world_prices_app/logic/helpers/file/file_helper.dart';
import 'package:world_prices_app/logic/helpers/firebase/firebase_helper.dart';
import 'package:path/path.dart';

class EuropeGroup extends StatefulWidget {
  const EuropeGroup({super.key});
  @override
  State<EuropeGroup> createState() => _EuropeGroupState();
}

class _EuropeGroupState extends State<EuropeGroup> {
  late List<Stream<bool>>? streamList;
  List<bool> downloading =
      List.generate(europeCountries.length, (index) => false);
  List<double> progressValue =
      List.generate(europeCountries.length, (index) => 0.0);


  @override
  void initState() {
    super.initState();
    List<Stream<bool>> temp = List.generate(europeCountries.length, (index) {
      return FileHelper.instance
          .existsStream(europeEq[europeCountries[index]]![2])
          .asBroadcastStream();
    });
    streamList = temp;
  }

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
            child: InkWell(
              child: Center(
                child: Column(
                  children: [
                    Text(europeEq[current]![0]),
                    StreamBuilder<bool>(
                      stream: streamList![index],
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!) {
                            if (!downloading[index]) {
                              return const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              );
                            } else {
                              return const Icon(
                                Icons.downloading_outlined,
                                color: Colors.blue,
                              );
                            }
                          } else {
                            return const Icon(
                              Icons.close_rounded,
                              color: Colors.red,
                            );
                          }
                        } else {
                          return const SizedBox(
                            height: 20,
                            width: 20,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                    progressBar(index),
                  ],
                ),
              ),
              onTap: () {
                final firebaseRef = europeEq[current]![1];
                final name = europeEq[current]![2];
                final fileExist =
                    FileHelper.instance.exists(europeEq[current]![2]);
                fileExist.then(
                  (value) {
                    //check if file exist
                    if (value) {
                      //check if currently downloading
                      if (!downloading[index]) {

                        //check if not corrupted
                        DatabaseHelperEurope.instance.check(current, europeEq[current]![2]).then((value) {
                          if (value) {
                            context.goNamed(
                              "europe_country",
                              params: {
                                'title': europeEq[current]![0],
                                'code': current
                              },
                            );
                          } else {
                            redownloadloadDialog(name, firebaseRef, index);
                          }
                        },);
                      } else {
                        preventOpening();
                      }
                    } else {
                      downloadDialog(name, firebaseRef, index);
                    }
                  },
                );
              },
            ),
          );
        },
      ),
      gridDelegate: gridDelegate,
    );
  }

  //creates a pop up asking to download data
  void downloadDialog(String name, String firebaseRef, int index) {
    showDialog(
      barrierDismissible: false,
      context: this.context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Database Not Found"),
          content: const Text(
              "There are no existing database, do you want to download?"),
          actions: [
            OutlinedButton(
              onPressed: () {
                return Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                download(index, name, firebaseRef);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  void redownloadloadDialog(String name, String firebaseRef, int index) {
    showDialog(
      barrierDismissible: false,
      context: this.context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Database Error"),
          content: const Text(
              "The database might be corrupted, do you want to redownload?"),
          actions: [
            OutlinedButton(
              onPressed: () {
                return Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                reDownload(index, name, firebaseRef);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  // //this shows an alert that displays the download progress
  // void progress(String url, String filePath, int index) async {
  //   ValueNotifier _progressValue = ValueNotifier<double>(0.0);
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return ValueListenableBuilder(
  //         valueListenable: _progressValue,
  //         builder: (context, value, child) {
  //           return AlertDialog(
  //             title: const Text("Downloading database"),
  //             content: Wrap(
  //               children: [
  //                 Center(child: Text((value * 100).toString())),
  //                 LinearProgressIndicator(
  //                   value: value,
  //                   color: Colors.amber,
  //                 )
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  //   await Future.delayed(Duration(seconds: 1));
  //   if (context.mounted) {
  //     Navigator.of(context).pop();
  //   }
  // }

  Widget progressBar(int index) {
    if (downloading[index]) {
      return Wrap(children: [
        LinearProgressIndicator(
          value: progressValue[index],
          color: Colors.yellow,
        ),
        Text("${(progressValue[index] * 100)}")
      ]);
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }

  void preventOpening() {
    showDialog(
      context: this.context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Warning!"),
          content: const Text("The database download is in progress"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  void download(int index, String name, String firebaseRef) async {
    final url = await FirebaseStorageHelper.instance.downloadUrl(firebaseRef);

    final privateStorage = await getExternalStorageDirectory();

    final filePath = "${privateStorage!.path}/$name";
    await Dio().download(
      url,
      filePath,
      onReceiveProgress: (received, total) async {
        double current = received / total;
        setState(() {
          progressValue[index] = current;
          downloading[index] = true;
        });
      },
    );
    setState(() {
      downloading[index] = false;
    });
  }

  void reDownload(int index, String name, String refPath) async {
    var databasesPath = await getExternalStorageDirectory();
    var path = join(databasesPath!.path, name);
    final file = File(path);
    file.delete();
    download(index, name, refPath);
  }
}
