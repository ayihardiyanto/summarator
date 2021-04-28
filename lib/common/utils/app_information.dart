import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';
import 'package:summarator/common/constants/shared_preferences_constants.dart';
import 'package:summarator/data/model/package_information_model.dart';

import 'local_storage.dart';

abstract class AppInformation {
  Future<void> getAppInfo();
}
@LazySingleton(as: AppInformation)
class AppInformationImpl extends AppInformation {
  final LocalStorage localStorage;

  AppInformationImpl({required this.localStorage});
  @override
  Future<void> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    String encodedPackageInfo = PackageInformationModel(
      appName: appName,
      buildNumber: buildNumber,
      packageName: packageName,
      version: version,
    ).toString();
    await localStorage.setString(SharedPreferencesKey.packageInfo, encodedPackageInfo);
  }
}
