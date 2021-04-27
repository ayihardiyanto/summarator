import 'package:injectable/injectable.dart';
import 'package:summarator/common/constants/local_datasource_boxname_constant.dart';
import 'package:summarator/common/utils/database_utils.dart';
import 'package:summarator/data/datasource/local/databases/summary_table.dart';
import 'package:summarator/data/model/summary_model.dart';

import 'base_local_datasource.dart';

@lazySingleton
class SummaryLocalDatasource
    extends BaseLocalDataSource<SummaryTable, SummaryModel> {
  SummaryLocalDatasource()
      : super(boxName: LocalDataSourceBoxNameConstants.summary) {
    DatabaseUtil.registerAdapter<SummaryTable>(SummaryTableAdapter());
  }

  @override
  Future<List<SummaryModel>> getFormattedData() async {
    final List<SummaryTable> configs = await getAll();
    return configs
        .map((config) => SummaryModel.fromTable(table: config))
        .toList();
  }

  Future<SummaryModel?> getFormattedItem(String key) async {
    final SummaryTable? table = await get(key);
    if (table != null) {
      return SummaryModel.fromTable(table: table);
    }
    return null;
  }

  @override
  Future<void> insertOrUpdateItems(List<SummaryModel> type,
      {bool checkIsUpdated = false}) async {
    final Map<String, SummaryTable> configMap = {
      for (SummaryModel model in type)
        if (!checkIsUpdated)
          model.originalText!: SummaryTable.fromModel(model: model)
    };
    await putAll(configMap);
  }

  Future<void> insertOrUpdateItem(SummaryModel model, String key,
      {bool checkIsUpdated = false}) async {
    late SummaryTable table;
    if (!checkIsUpdated) table = SummaryTable.fromModel(model: model);
    await put(
      key,
      table,
    );
  }
}
