import 'package:world_prices_app/constants.dart';

import '../../../helpers/file/file_helper.dart';

class EuropeGroupState {
  late List<Stream<bool>> sreamList;
  late List<bool> downloading;
  late List<double> progressValue;

  EuropeGroupState._privateConstructor();

  factory EuropeGroupState.initial() {
    int index = europeCountries.length;
    return EuropeGroupState._privateConstructor()
      ..sreamList = List.generate(
          index,
          (i) => FileHelper.instance
              .existsStream(europeEq[europeCountries[i]]![2])
              .asBroadcastStream())
      ..downloading = List.generate(index, (i) => false)
      ..progressValue = List.generate(index, (i) => 0.0);
  }
}
