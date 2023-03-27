import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoadingSliver extends StatefulWidget {
  const LoadingSliver({super.key});

  @override
  State<LoadingSliver> createState() => _LoadingSliverState();
}

class _LoadingSliverState extends State<LoadingSliver> {
  SliverGridDelegate gridDelegate =
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1);
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: 1,
      gridDelegate: gridDelegate,
      itemBuilder: (context, index) {
        return CircularProgressIndicator();
      },
    );
  }
}
