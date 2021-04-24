import 'package:logger/logger.dart';
import 'package:summarator/common/constants/common_constants.dart';
import 'package:summarator/env.dart';

class LoggerConfig extends Logger {
  LogPrinter printer;
  // ignore: overridden_fields
  Level level;

  LoggerConfig({
    required this.printer,
    required this.level,
  }) : super(
          printer: printer,
          level: level,
        );

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      e('[ERROR] $message', error, stackTrace);

  void warn(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      w('[WARN] $message', error, stackTrace);

  void info(dynamic message) => i('[INFO] $message');

  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      d('[DEBUG] $message', error, stackTrace);

  void verbose(dynamic message) => v('[VERBOSE]\n$message');

  static Level logLevel() {
    if (environment[CommonConstants.environment] ==
        CommonConstants.production) {
      return Level.nothing;
    } else {
      return Level.verbose;
    }
  }
}
