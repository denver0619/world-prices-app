class DatabaseContent {
  final String dataflow, last_update, freq, unit, coicop, geo, time_period, obs_value,obs_flag;

  DatabaseContent({required this.dataflow,
  required this.last_update,
  required this.freq,
  required this.unit,
  required this.coicop,
  required this.geo,
  required this.time_period,
  required this.obs_value,
  required this.obs_flag});

  factory DatabaseContent.fromMap(Map<String, dynamic> result) {
    return DatabaseContent(
      dataflow: result['DATAFLOW'],
      last_update: result['LAST UPDATE'],
      freq: result['freq'],
      unit: result['unit'],
      coicop: result['coicop'],
      geo: result['geo'],
      time_period: result['TIME_PERIOD'],
      obs_value: result['OBS_VALUE'],
      obs_flag: result['OBS_FLAG']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'DATAFLOW' : dataflow,
      'LAST UPDATE' : last_update,
      'freq' : freq,
      'unit' : unit,
      'coicop' : coicop,
      'geo' : geo,
      'TIME_PERIOD' : time_period,
      'OBS_VALUE' : obs_value,
      'OBS_FLAGE' : obs_flag
    };
  }
}