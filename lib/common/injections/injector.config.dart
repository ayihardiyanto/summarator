// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:connectivity/connectivity.dart' as _i6;
import 'package:dio/dio.dart' as _i9;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/datasource/firebase_auth_datasource.dart' as _i3;
import '../../data/repos/summary_repository.dart' as _i8;
import '../../data/repos/user_firebase_repository.dart' as _i11;
import '../../domain/repos/summary_repository.dart' as _i7;
import '../../domain/repos/user_firebase_repository.dart' as _i10;
import '../../domain/usecases/summary_usecase.dart' as _i12;
import '../utils/network_check.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.IFirebaseAuthDatasource>(
      () => _i3.FirebaseAuthDatasource(firebaseAuth: get<_i4.FirebaseAuth>()));
  gh.lazySingleton<_i5.NetworkCheck>(
      () => _i5.NetworkCheckImpl(connectivity: get<_i6.Connectivity>()));
  gh.lazySingleton<_i7.ISummaryRepository>(() => _i8.SummaryRepository(
      networkCheck: get<_i5.NetworkCheck>(), dio: get<_i9.Dio>()));
  gh.lazySingleton<_i10.IUserFirebaseRepository>(() =>
      _i11.UserFireBaseRepository(
          networkCheck: get<_i5.NetworkCheck>(),
          firebaseAuthDatasource: get<_i3.FirebaseAuthDatasource>()));
  gh.factory<_i12.GetSummaryUsecase>(() =>
      _i12.GetSummaryUsecase(summaryRepository: get<_i7.ISummaryRepository>()));
  return get;
}
