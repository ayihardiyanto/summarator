import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:summarator/common/errors/no_connection.dart';
import 'package:summarator/data/model/__mock__/summary_model_dummy.dart';
import 'package:summarator/domain/usecases/__mock__/get_summary_payload_mock.dart';
import 'package:summarator/domain/usecases/summary_usecase.dart';
import 'package:summarator/presentation/screen/summarator/bloc/summarize_bloc.dart';

import '../../../../domain/usecases/summary_usecase_test.mocks.dart';

void main() {
  late GetSummaryUsecase getSummaryUsecase;
  late SummarizeBloc summarizeBloc;

  setUp(() {
    getSummaryUsecase = MockGetSummaryUsecase();
    summarizeBloc = SummarizeBloc(getSummaryUsecase: getSummaryUsecase);
  });

  group('GetSummarization', () {
    blocTest<SummarizeBloc, SummarizeState>(
      'should yield Summarizing and Summarized',
      build: () {
        when(getSummaryUsecase.call(dummySummaryPayloadTrue)).thenAnswer(
          (realInvocation) async => Right(dummySummary),
        );
        return summarizeBloc;
      },
      act: (bloc) =>
          bloc.add(GetSummarization(text: dummySummary.originalText!)),
      expect: () => [isA<Summarizing>(), isA<Summarized>()],
    );

    blocTest<SummarizeBloc, SummarizeState>(
      'should yield Summarizing and SummarizingError',
      build: () {
        when(getSummaryUsecase.call(dummySummaryPayloadTrue)).thenAnswer(
          (realInvocation) async => Left(NoConnectionError()),
        );
        return summarizeBloc;
      },
      act: (bloc) =>
          bloc.add(GetSummarization(text: dummySummary.originalText!)),
      expect: () => [isA<Summarizing>(), isA<SummarizingError>()],
    );
  });
  blocTest<SummarizeBloc, SummarizeState>(
    'should yield Summarizing and Summarized',
    build: () => summarizeBloc,
    act: (bloc) => bloc.add(GetSummarizationFromHistory(summary: dummySummary)),
    expect: () => [isA<Summarizing>(), isA<Summarized>()],
  );

  blocTest<SummarizeBloc, SummarizeState>(
    'should yield SummaryDismissed',
    build: () => summarizeBloc,
    act: (bloc) => bloc.add(DismissSummary()),
    expect: () => [isA<SummaryDismissed>()],
  );
}
