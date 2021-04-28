import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';
import 'package:summarator/common/utils/logger.dart';
import 'package:summarator/presentation/screen/summarator/bloc/activity_bloc.dart';
import 'package:summarator/presentation/screen/summarator/bloc/history_bloc.dart';
import 'package:summarator/presentation/screen/summarator/bloc/summarize_bloc.dart';
import 'package:summarator/presentation/screen/summarator/summarator_screen.dart';
import 'package:summarator/presentation/theme/theme_data.dart';

import 'common/injections/injector.dart';
import 'common/utils/app_information.dart';
import 'common/utils/database_utils.dart';
import 'common/utils/screen_config.dart';

Future<void> main() async {
  await DatabaseUtil.initDatabase();
  runZonedGuarded(() {
    runApp(MyApp());
  }, (Object error, StackTrace stackTrace) {
    // Whenever an error occurs, call the `_reportError` function. This sends
    // Dart errors to the dev console or Sentry depending on the environment.
    Log.e('Execution Error: $error');
    Log.e('Stack Trace: $stackTrace');
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppInformation appInfo;
  @override
  void initState() {
    appInfo = getIt<AppInformation>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    unawaited(appInfo.getAppInfo());
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );
    WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          ScreenConfig.init(constraints);
          return MaterialApp(
              theme: themeData,
              debugShowCheckedModeBanner: false,
              home: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => getIt<SummarizeBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<ActivityBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<HistoryBloc>(),
                  ),
                ],
                child: SummaratorScreen(),
              ));
        },
      ),
    );
  }
}
