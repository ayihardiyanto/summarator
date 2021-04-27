import 'package:summarator/common/constants/local_datasource_boxname_constant.dart';
import 'package:summarator/common/injections/injector.dart';

import '../base_local_datasource.dart';
import '../summary_local_datasource.dart';

class LocalDataSourceMap {
  static final Map<String, BaseLocalDataSource> boxes = {
    LocalDataSourceBoxNameConstants.summary:
        getIt<SummaryLocalDatasource>(),
  };
}
