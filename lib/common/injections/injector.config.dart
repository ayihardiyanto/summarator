// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:connectivity/connectivity.dart' as _i6;
import 'package:dio/dio.dart' as _i10;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/datasource/firebase_auth_datasource.dart' as _i3;
import '../../data/datasource/local/summary_local_datasource.dart' as _i7;
import '../../data/repos/summary_repository.dart' as _i9;
import '../../data/repos/user_firebase_repository.dart' as _i12;
import '../../domain/repos/summary_repository.dart' as _i8;
import '../../domain/repos/user_firebase_repository.dart' as _i11;
import '../../domain/usecases/summary_usecase.dart' as _i13;
import '../../presentation/screen/summarator/bloc/activity_bloc.dart' as _i16;
import '../../presentation/screen/summarator/bloc/history_bloc.dart' as _i14;
import '../../presentation/screen/summarator/bloc/summarize_bloc.dart' as _i15;
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
  gh.lazySingleton<_i7.SummaryLocalDatasource>(
      () => _i7.SummaryLocalDatasource());
  gh.lazySingleton<_i8.ISummaryRepository>(() => _i9.SummaryRepository(
      networkCheck: get<_i5.NetworkCheck>(),
      dio: get<_i10.Dio>(),
      localDatasource: get<_i7.SummaryLocalDatasource>()));
  gh.lazySingleton<_i11.IUserFirebaseRepository>(() =>
      _i12.UserFireBaseRepository(
          networkCheck: get<_i5.NetworkCheck>(),
          firebaseAuthDatasource: get<_i3.FirebaseAuthDatasource>()));
  gh.factory<_i13.UnfavoriteUsecase>(() =>
      _i13.UnfavoriteUsecase(summaryRepository: get<_i8.ISummaryRepository>()));
  gh.factory<_i13.AddToFavoriteUsecase>(() => _i13.AddToFavoriteUsecase(
      summaryRepository: get<_i8.ISummaryRepository>()));
  gh.factory<_i13.ClearHistoryUsecase>(() => _i13.ClearHistoryUsecase(
      summaryRepository: get<_i8.ISummaryRepository>()));
  gh.factory<_i13.GetHistoryUsecase>(() =>
      _i13.GetHistoryUsecase(summaryRepository: get<_i8.ISummaryRepository>()));
  gh.factory<_i13.GetSummaryUsecase>(() =>
      _i13.GetSummaryUsecase(summaryRepository: get<_i8.ISummaryRepository>()));
  gh.factory<_i14.HistoryBloc>(() => _i14.HistoryBloc(
      getHistoryUsecase: get<_i13.GetHistoryUsecase>(),
      clearHistoryUsecase: get<_i13.ClearHistoryUsecase>()));
  gh.factory<_i15.SummarizeBloc>(() =>
      _i15.SummarizeBloc(getSummaryUsecase: get<_i13.GetSummaryUsecase>()));
  gh.factory<_i16.ActivityBloc>(() => _i16.ActivityBloc(
      addToFavoriteUsecase: get<_i13.AddToFavoriteUsecase>(),
      unfavoriteUsecase: get<_i13.UnfavoriteUsecase>()));
  return get;
}
