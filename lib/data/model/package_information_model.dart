import 'dart:convert';

import 'package:summarator/common/constants/common_constants.dart';
import 'package:summarator/domain/entities/package_information.dart';


class PackageInformationModel extends PackageInformation {
  PackageInformationModel({
    required String appName,
    required String buildNumber,
    required String packageName,
    required String version,
  }) : super(
          appName: appName,
          buildNumber: buildNumber,
          packageName: packageName,
          version: version,
        );

  factory PackageInformationModel.fromJson({dynamic json}) {
    return PackageInformationModel(
      appName: json[CommonConstants.appName],
      buildNumber: json[CommonConstants.buildNumber] as String,
      packageName: json[CommonConstants.packageName],
      version: json[CommonConstants.version],
    );
  }

  Map<String, String> toJson() {
    return {
      CommonConstants.appName: appName,
      CommonConstants.buildNumber: buildNumber,
      CommonConstants.packageName: packageName,
      CommonConstants.version: version,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
