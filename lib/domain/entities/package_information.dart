import 'package:equatable/equatable.dart';

class PackageInformation extends Equatable {
  final String appName;
  final String buildNumber;
  final String packageName;
  final String version;

  PackageInformation({
    required this.appName,
    required this.buildNumber,
    required this.packageName,
    required this.version,
  });
  @override
  List<Object> get props => [
        appName,
        buildNumber,
        packageName,
        version,
      ];
}