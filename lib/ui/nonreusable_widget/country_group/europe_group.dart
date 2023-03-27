import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:world_prices_app/constants.dart';
import 'package:world_prices_app/logic/helpers/file/file_helper.dart';
import 'package:world_prices_app/logic/helpers/firebase/firebase_helper.dart';
import 'dart:convert';

class EuropeGroup extends StatefulWidget {
  const EuropeGroup({super.key});
  @override
  State<EuropeGroup> createState() => _EuropeGroupState();
}

class _EuropeGroupState extends State<EuropeGroup> {
  FileHelper fileHelper = FileHelper();
  late List<Stream<bool>>? streamList;

  @override
  void initState() {
    super.initState();
    List<Stream<bool>> temp = List.generate(europeCountries.length, (index) {
      return FileHelper()
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
                              return const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              );
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
                        })
                  ],
                ),
              ),
              onTap: () {
                final firebaseRef = europeEq[current]![1];
                final name = europeEq[current]![2];
                final fileExist = fileHelper.exists(europeEq[current]![2]);
                fileExist.then(
                  (value) {
                    if (value) {
                      context.goNamed(
                        "europe_country",
                        params: {
                          'title': europeEq[current]![0],
                          'code': current
                        },
                      );
                    } else {
                      downloadDialog(context, name, firebaseRef, index);
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
  void downloadDialog(
      BuildContext context, String name, String refPath, int index) {
    showDialog(
      barrierDismissible: false,
      context: context,
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
              onPressed: () async {
                final url =
                    await FirebaseStorageHelper.instance.downloadUrl(refPath);

                final privateStorage = await getExternalStorageDirectory();

                final filePath = "${privateStorage!.path}/$name";
                if (context.mounted) {
                  Navigator.of(context).pop();
                  progress(url, filePath, index);
                }
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  //this shows an alert that displays the download progress
  void progress(String url, String filePath, int index) async {
    ValueNotifier _progressValue = ValueNotifier<double>(0.0);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ValueListenableBuilder(
          valueListenable: _progressValue,
          builder: (context, value, child) {
            return AlertDialog(
              title: const Text("Downloading database"),
              content: Wrap(
                children: [
                  Center(child: Text((value * 100).toString())),
                  LinearProgressIndicator(
                    value: value,
                    color: Colors.amber,
                  )
                ],
              ),
            );
          },
        );
      },
    );

    await Dio().download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        double current = received / total;
        setState(
          () {
            _progressValue.value = current;
          },
        );
      },
    );
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
