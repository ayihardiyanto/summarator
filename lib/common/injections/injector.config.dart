// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:connectivity/connectivity.dart' as _i8;
import 'package:dio/dio.dart' as _i14;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../../data/datasource/firebase_auth_datasource.dart' as _i3;
import '../../data/datasource/local/summary_local_datasource.dart' as _i10;
import '../../data/repos/summary_repository.dart' as _i13;
import '../../data/repos/user_firebase_repository.dart' as _i16;
import '../../domain/repos/summary_repository.dart' as _i12;
import '../../domain/repos/user_firebase_repository.dart' as _i15;
import '../../domain/usecases/summary_usecase.dart' as _i17;
import '../../presentation/screen/summarator/bloc/activity_bloc.dart' as _i20;
import '../../presentation/screen/summarator/bloc/history_bloc.dart' as _i18;
import '../../presentation/screen/summarator/bloc/summarize_bloc.dart' as _i19;
import '../utils/app_information.dart' as _i11;
import '../utils/local_storage.dart' as _i5;
import '../utils/network_check.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.IFirebaseAuthDatasource>(
      () => _i3.FirebaseAuthDatasource(firebaseAuth: get<_i4.FirebaseAuth>()));
  gh.lazySingleton<_i5.LocalStorage>(() =>
      _i5.LocalStorageImpl(sharedPreferences: get<_i6.SharedPreferences>()));
  gh.lazySingleton<_i7.NetworkCheck>(
      () => _i7.NetworkCheckImpl(connectivity: get<_i8.Connectivity>()));
  gh.lazySingleton<_i10.SummaryLocalDatasource>(
      () => _i10.SummaryLocalDatasource());
  gh.lazySingleton<_i11.AppInformation>(
      () => _i11.AppInformationImpl(localStorage: get<_i5.LocalStorage>()));
  gh.lazySingleton<_i12.ISummaryRepository>(() => _i13.SummaryRepository(
      networkCheck: get<_i7.NetworkCheck>(),
      dio: get<_i14.Dio>(),
      localDatasource: get<_i10.SummaryLocalDatasource>()));
  gh.lazySingleton<_i15.IUserFirebaseRepository>(() =>
      _i16.UserFireBaseRepository(
          networkCheck: get<_i7.NetworkCheck>(),
          firebaseAuthDatasource: get<_i3.FirebaseAuthDatasource>()));
  gh.factory<_i17.UnfavoriteUsecase>(() => _i17.UnfavoriteUsecase(
      summaryRepository: get<_i12.ISummaryRepository>()));
  gh.factory<_i17.AddToFavoriteUsecase>(() => _i17.AddToFavoriteUsecase(
      summaryRepository: get<_i12.ISummaryRepository>()));
  gh.factory<_i17.ClearHistoryUsecase>(() => _i17.ClearHistoryUsecase(
      summaryRepository: get<_i12.ISummaryRepository>()));
  gh.factory<_i17.GetHistoryUsecase>(() => _i17.GetHistoryUsecase(
      summaryRepository: get<_i12.ISummaryRepository>()));
  gh.factory<_i17.GetSummaryUsecase>(() => _i17.GetSummaryUsecase(
      summaryRepository: get<_i12.ISummaryRepository>()));
  gh.factory<_i18.HistoryBloc>(() => _i18.HistoryBloc(
      getHistoryUsecase: get<_i17.GetHistoryUsecase>(),
      clearHistoryUsecase: get<_i17.ClearHistoryUsecase>()));
  gh.factory<_i19.SummarizeBloc>(() =>
      _i19.SummarizeBloc(getSummaryUsecase: get<_i17.GetSummaryUsecase>()));
  gh.factory<_i20.ActivityBloc>(() => _i20.ActivityBloc(
      addToFavoriteUsecase: get<_i17.AddToFavoriteUsecase>(),
      unfavoriteUsecase: get<_i17.UnfavoriteUsecase>()));
  return get;
}
