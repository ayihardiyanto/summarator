import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:summarator/common/errors/no_connection.dart';
import 'package:summarator/common/usecase/usecase.dart';
import 'package:summarator/data/model/__mock__/summary_model_dummy.dart';
import 'package:summarator/domain/usecases/summary_usecase.dart';
import 'package:summarator/presentation/screen/summarator/bloc/activity_bloc.dart';
import 'package:summarator/presentation/screen/summarator/bloc/history_bloc.dart';

import '../../../../domain/usecases/summary_usecase_test.mocks.dart';

void main() {
  late GetHistoryUsecase getHistoryUsecase;
  late ClearHistoryUsecase clearHistoryUsecase;
  late AddToFavoriteUsecase addToFavoriteUsecase;
  late UnfavoriteUsecase unfavoriteUsecase;
  late HistoryBloc historyBloc;
  late ActivityBloc activityBloc;

  setUp(() {
    getHistoryUsecase = MockGetHistoryUsecase();
    clearHistoryUsecase = MockClearHistoryUsecase();
    addToFavoriteUsecase = MockAddToFavoriteUsecase();
    unfavoriteUsecase = MockUnfavoriteUsecase();
    historyBloc = HistoryBloc(
      getHistoryUsecase: getHistoryUsecase,
      clearHistoryUsecase: clearHistoryUsecase,
    );
    activityBloc = ActivityBloc(
      addToFavoriteUsecase: addToFavoriteUsecase,
      unfavoriteUsecase: unfavoriteUsecase,
    );
  });

  group('addSubscription', () {
    test(
      'should call GetHistory when FavoriteUpdated',
      () async {
        historyBloc.addSubscription(activityBloc);
        // arrange
        when(addToFavoriteUsecase.call(dummySummary))
            .thenAnswer((realInvocation) async => Right(true));
        when(getHistoryUsecase.call(NoParams()))
            .thenAnswer((realInvocation) async => Right([]));

        // act
        activityBloc.add(AddToFavorite(summary: dummySummary));
      },
    );
  });

  group('GetHistory', () {
    blocTest<HistoryBloc, HistoryState>(
      'should yield HistoryLoaded',
      build: () {
        when(getHistoryUsecase.call(NoParams())).thenAnswer(
          (realInvocation) async => Right([]),
        );
        return historyBloc;
      },
      act: (bloc) => bloc.add(GetHistory()),
      expect: () => [isA<HistoryLoaded>()],
    );

    blocTest<HistoryBloc, HistoryState>(
      'should yield HistoryError',
      build: () {
        when(getHistoryUsecase.call(NoParams())).thenAnswer(
          (realInvocation) async => Left(NoConnectionError()),
        );
        return historyBloc;
      },
      act: (bloc) => bloc.add(GetHistory()),
      expect: () => [isA<HistoryError>()],
    );
  });

  blocTest<HistoryBloc, HistoryState>(
    'ClearHistory should yield HistoryLoading and HistoryCleared',
    build: () {
      when(clearHistoryUsecase.call(NoParams())).thenAnswer(
        (realInvocation) async => Right(true),
      );
      when(getHistoryUsecase.call(NoParams())).thenAnswer(
        (realInvocation) async => Right([]),
      );
      return historyBloc;
    },
    act: (bloc) => bloc.add(ClearHistory()),
    expect: () =>
        [isA<HistoryLoading>(), isA<HistoryCleared>(), isA<HistoryLoaded>()],
  );
}
