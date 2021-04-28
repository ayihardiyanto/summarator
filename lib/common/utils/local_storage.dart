import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<void> setString(String key, String value);
  Future<void> setBool(String key, bool value);
  String? getString(String key);
  bool? getBool(String key);
  List<String>? getStringList(String key);
  Future<void> setStringList(String key, List<String> value);
  Future<void> clear();
  Future<void> remove(String key);
}

@LazySingleton(as: LocalStorage)
class LocalStorageImpl implements LocalStorage {
  final SharedPreferences sharedPreferences;

  LocalStorageImpl({required this.sharedPreferences});

  @override
  bool? getBool(String key) {
    return sharedPreferences.getBool(key);
  }

  @override
  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  @override
  Future<void> setString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await sharedPreferences.setStringList(key, value);
  }

  @override
  List<String>? getStringList(String key) {
    return sharedPreferences.getStringList(key);
  }

  @override
  Future<void> clear() async {
    await sharedPreferences.clear();
  }

  @override
  Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
  }
}
