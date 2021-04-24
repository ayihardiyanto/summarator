import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:summarator/presentation/theme/theme_data.dart';

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
            // home: SplashScreen(),
          );
        },
      ),
    );
  }
}
