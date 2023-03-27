import 'package:flutter/material.dart';

abstract class EuropeGroupEvent {
  final int index;
  EuropeGroupEvent(this.index);
}

class EuropeUpdateProgress extends EuropeGroupEvent {
  double value;
  EuropeUpdateProgress(super.index, this.value);
}

class EuropeDownloading extends EuropeGroupEvent {
  EuropeDownloading(super.index);
}

class EuropeFinishedDownloading extends EuropeGroupEvent {
  EuropeFinishedDownloading(super.index);
}
