// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:summarator/app.dart' as app;
import 'package:summarator/common/injections/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await setupInjections();
  await app.main();
}
