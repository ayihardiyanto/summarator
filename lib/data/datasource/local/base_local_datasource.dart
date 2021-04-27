import 'package:hive/hive.dart';
import 'package:summarator/common/utils/database_utils.dart';
import 'package:summarator/common/utils/logger.dart';

import 'constants/base_local_datasource_constant.dart';

abstract class BaseLocalDataSource<TableType, ModelType> {
  late String _boxName;
  Future<Box<TableType>>? boxInstance;

  BaseLocalDataSource({
    required String boxName,
  }) {
    _boxName = boxName;
  }

  void _init() {
    boxInstance = DatabaseUtil.getBox<TableType>(boxName: _boxName);
  }

  Future<Box<TableType>> get getBoxInstance async => _openBox();
  Future<List<ModelType>> getFormattedData();
  Future<void> insertOrUpdateItems(List<ModelType> type);

  Future<Box<TableType>> _recoverBoxOnFailure([bool isError = false]) async {
    try {
      if (isError) {
        await DatabaseUtil.clearBox(_boxName);
      }
      _init();
      final Box<TableType> box = await boxInstance!;
      return box;
    } on TypeError {
      return _recoverBoxOnFailure(true);
    } on HiveError catch (e) {
      if (e.message == BaseLocalDatasourceConstant.unexpectedHiveErrorMessage) {
        Log.error('Unexpected HiveError while opening '
            'box $_boxName because ${e.message}');
        return _recoverBoxOnFailure(true);
      }
      rethrow;
    }
  }

  Future<Box<TableType>> _openBox() async {
    if (boxInstance == null) {
      _init();
    }
    Box<TableType> box = await boxInstance!;
    if (!box.isOpen) {
      box = await _recoverBoxOnFailure();
    }
    return box;
  }

  Future<TableType?> get(String key) async {
    final Box<TableType> box = await _openBox();
    return box.get(key);
  }

  Future<List<TableType>> getAll() async {
    final Box<TableType> box = await _openBox();
    return box.toMap().values.toList();
  }

  Future<void> put(String key, TableType value) async {
    final Box<TableType> box = await _openBox();
    await box.put(key, value);
  }

  Future<void> putAll(Map<String, TableType> items) async {
    final Box<TableType> box = await _openBox();
    await box.putAll(items);
  }

  Future<void> delete(String key) async {
    final Box<TableType> box = await _openBox();
    await box.delete(key);
  }

  Future<void> deleteAll() async {
    final Box<TableType> box = await _openBox();
    final List<String> boxKeys = await keys;
    await box.deleteAll(boxKeys);
  }

  Future<List<String>> get keys async {
    final Box<TableType> box = await _openBox();
    final List<String> result = box.keys.map((k) => k.toString()).toList();
    return result;
  }
}
