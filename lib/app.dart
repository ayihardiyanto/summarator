import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summarator/presentation/screen/summarator/bloc/summarize_bloc.dart';
import 'package:summarator/presentation/screen/summarator/summarator_screen.dart';
import 'package:summarator/presentation/theme/theme_data.dart';

import 'common/injections/injector.dart';
import 'common/utils/screen_config.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            home: BlocProvider(
              create: (context) => getIt<SummarizeBloc>(),
              child: SummaratorScreen(),
            ),
          );
        },
      ),
    );
  }
}
