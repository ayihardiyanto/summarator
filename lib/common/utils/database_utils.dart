import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'logger.dart';

class DatabaseUtil {
 static Future<void> initDatabase() async {
   final Directory directory = await getApplicationDocumentsDirectory();
   Hive.init(directory.path);
 }

 static void registerAdapter<Type>(TypeAdapter<Type> adapter) {
    try {
      Hive.registerAdapter(adapter);
    } on HiveError catch (error) {
      Log.debug(error);
    }
  }

  static Future<Box<Type>> getBox<Type>({required String boxName}) async {
    return Hive.openBox(boxName);
  }

  static Future<void> clearBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }

  static Future<void> clearDatabase() async {
    await Hive.deleteFromDisk();
  }
}
