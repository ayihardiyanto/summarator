import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injector.config.dart' as injection_config;

final getIt = GetIt.instance;

Future<void> setupInjections() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  // final Dio dio = Dio();
  // this code originally from rest_client.dart setup()
  // dio.interceptors.add(TokenInterceptor());
  // dio.options.baseUrl = environment['baseUrl'];
  // dio.options.headers['content-type'] = 'application/json';

  final Reference firebaseStorage = FirebaseStorage.instance.ref();
  // final CloudFunctions cloudFunctions = CloudFunctions(region: 'asia-east2');
  // final FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // final RemoteConfig remoteConfig = await RemoteConfig.instance;

  getIt.registerLazySingleton(() => Connectivity());
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => Dio());
  // getIt.registerLazySingleton(() => dio);
  getIt.registerLazySingleton(() => firebaseStorage);
  // getIt.registerLazySingleton(() => cloudFunctions);
  // getIt.registerLazySingleton(() => crashlytics);
  // getIt.registerLazySingleton(() => FirebaseAnalytics());
  getIt.registerLazySingleton(() => firestore);
  getIt.registerLazySingleton(() => firebaseAuth);
  // getIt.registerLazySingleton(() => remoteConfig);
  configure();
}

@injectableInit
void configure() => injection_config.$initGetIt(getIt);
