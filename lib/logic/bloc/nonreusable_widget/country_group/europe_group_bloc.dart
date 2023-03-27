import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:world_prices_app/logic/bloc/nonreusable_widget/country_group/europe_group_event.dart';
import 'package:world_prices_app/logic/bloc/nonreusable_widget/country_group/europe_group_state.dart';

import '../../../../constants.dart';
import '../../../helpers/firebase/firebase_helper.dart';

class EuropeGroupBloc extends Bloc<EuropeGroupEvent, EuropeGroupState> {
  EuropeGroupBloc(super.initialState);

  // EuropeGroupState get initialState => EuropeGroupState.initial();

  Stream<EuropeGroupState> mapEventToState(
    EuropeGroupState currentState,
    EuropeGroupEvent event,
  ) async* {
    if (event is EuropeUpdateProgress) {
      yield currentState..progressValue[event.index] = event.value;
    } else if (event is EuropeDownloading) {
      final current = europeCountries[event.index];
      final equivalent = europeEq[current];

      final url =
          await FirebaseStorageHelper.instance.downloadUrl(equivalent![1]);

      final privateStorage = await getExternalStorageDirectory();

      final filePath = "${privateStorage!.path}/${equivalent[2]}";
      await Dio().download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          double current = received / total;
          currentState.progressValue[event.index] = current;
          currentState.downloading[event.index] = true;
        },
      );
      yield currentState;
    } else if (event is EuropeFinishedDownloading) {
      currentState.downloading[event.index] = false;
      yield currentState;
    }
  }
}
