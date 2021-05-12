import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:summarator/common/constants/common_constants.dart';
import 'package:summarator/data/model/__mock__/summary_model_dummy.dart';
import 'package:summarator/domain/entities/summary_entity.dart';
import 'package:summarator/domain/usecases/__mock__/get_summary_payload_mock.dart';
import 'package:summarator/domain/usecases/summary_usecase.dart';
import 'package:summarator/presentation/screen/summarator/bloc/activity_bloc.dart';
import 'package:summarator/presentation/screen/summarator/bloc/summarize_bloc.dart';

import '../../../../domain/usecases/summary_usecase_test.mocks.dart';

void main() {
  late AddToFavoriteUsecase addToFavoriteUsecase;
  late UnfavoriteUsecase unfavoriteUsecase;
  late ActivityBloc activityBloc;
  late SummarizeBloc summarizeBloc;
  late GetSummaryUsecase getSummaryUsecase;

  setUp(() {
    addToFavoriteUsecase = MockAddToFavoriteUsecase();
    unfavoriteUsecase = MockUnfavoriteUsecase();
    getSummaryUsecase = MockGetSummaryUsecase();
    summarizeBloc = SummarizeBloc(getSummaryUsecase: getSummaryUsecase);
    activityBloc = ActivityBloc(
      addToFavoriteUsecase: addToFavoriteUsecase,
      unfavoriteUsecase: unfavoriteUsecase,
    );
  });

  group('addSubscription', () {
    test(
      'should call usecase with params from SummarizeBloc yielding Summarized',
      () async {
        activityBloc.addSubscription(summarizeBloc);
        Summary summary = dummySummary;
        // arrange
        when(getSummaryUsecase.call(dummySummaryPayloadTrue))
            .thenAnswer((realInvocation) async => Right(summary));

        activityBloc.addSubscription(summarizeBloc);
        // act
        summarizeBloc.add(GetSummarization(text: dummySummary.originalText!));
      },
    );

    test(
      'should call usecase with params from SummarizeBloc yielding SummaryDismissed',
      () async {
        activityBloc.addSubscription(summarizeBloc);
        Summary summary = dummySummary;
        // arrange
        when(getSummaryUsecase.call(dummySummaryPayloadTrue))
            .thenAnswer((realInvocation) async => Right(summary));
        // act
        summarizeBloc.add(DismissSummary());
      },
    );
  });

  group('AttachListener', () {
    blocTest<ActivityBloc, ActivityState>(
      'should yield Listening and TextEmpty',
      build: () {
        activityBloc.addSubscription(summarizeBloc);
        return activityBloc;
      },
      act: (bloc) => bloc.add(AttachListener(
          isSummarized: true, text: CommonConstants.emptyString)),
      expect: () => [isA<Listening>(), isA<TextEmpty>()],
    );
    blocTest<ActivityBloc, ActivityState>(
      'should yield Listening and TextFilled',
      build: () {
        activityBloc.addSubscription(summarizeBloc);
        return activityBloc;
      },
      act: (bloc) => bloc.add(
          AttachListener(isSummarized: true, text: dummySummary.originalText!)),
      expect: () => [isA<Listening>(), isA<TextFilled>()],
    );
  });

  blocTest<ActivityBloc, ActivityState>(
    'AddToFavorite should yield UpdatingFavorite and FavoriteUpdated',
    build: () {
      activityBloc.addSubscription(summarizeBloc);
      when(addToFavoriteUsecase.call(dummySummary))
          .thenAnswer((realInvocation) async => Right(true));
      return activityBloc;
    },
    act: (bloc) => bloc.add(AddToFavorite(summary: dummySummary)),
    expect: () => [isA<UpdatingFavorite>(), isA<FavoriteUpdated>()],
  );

  blocTest<ActivityBloc, ActivityState>(
    'RemoveFavorite should yield UpdatingFavorite and FavoriteUpdated',
    build: () {
      activityBloc.addSubscription(summarizeBloc);
      when(unfavoriteUsecase.call(dummySummary))
          .thenAnswer((realInvocation) async => Right(true));
      return activityBloc;
    },
    act: (bloc) => bloc.add(RemoveFavorite(summary: dummySummary)),
    expect: () => [isA<UpdatingFavorite>(), isA<FavoriteUpdated>()],
  );

  blocTest<ActivityBloc, ActivityState>(
    'ResultBoxAddToFavorite should yield UpdatingFavorite and FavoriteUpdated',
    build: () {
      activityBloc.addSubscription(summarizeBloc);
      when(addToFavoriteUsecase.call(dummySummary))
          .thenAnswer((realInvocation) async => Right(true));
      return activityBloc;
    },
    act: (bloc) => bloc.add(ResultBoxAddToFavorite(summary: dummySummary)),
    expect: () => [isA<UpdatingFavorite>(), isA<FavoriteResultBoxUpdated>()],
  );

  blocTest<ActivityBloc, ActivityState>(
    'ResultBoxRemoveFavorite should yield UpdatingFavorite and FavoriteUpdated',
    build: () {
      activityBloc.addSubscription(summarizeBloc);
      when(unfavoriteUsecase.call(dummySummary))
          .thenAnswer((realInvocation) async => Right(true));
      return activityBloc;
    },
    act: (bloc) => bloc.add(ResultBoxRemoveFavorite(summary: dummySummary)),
    expect: () => [isA<UpdatingFavorite>(), isA<FavoriteResultBoxUpdated>()],
  );
}
