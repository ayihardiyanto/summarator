import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:summarator/common/usecase/usecase.dart';
import 'package:summarator/data/model/__mock__/summary_model_dummy.dart';
import 'package:summarator/domain/repos/summary_repository.dart';
import 'package:summarator/domain/usecases/__mock__/get_summary_payload_mock.dart';
import 'package:summarator/domain/usecases/summary_usecase.dart';

import '../../data/repos/summary_repository_test.mocks.dart';


@GenerateMocks([
  AddToFavoriteUsecase,
  UnfavoriteUsecase,
  GetSummaryUsecase,
  ClearHistoryUsecase,
  GetHistoryUsecase,
])
void main() {
  late ISummaryRepository repository;
  late GetSummaryUsecase getSummaryUsecase;
  late AddToFavoriteUsecase addToFavoriteUsecase;
  late UnfavoriteUsecase unfavoriteUsecase;
  late ClearHistoryUsecase clearHistoryUsecase;
  late GetHistoryUsecase getHistoryUsecase;

  setUp(() {
    repository = MockISummaryRepository();
    getSummaryUsecase = GetSummaryUsecase(summaryRepository: repository);
    addToFavoriteUsecase = AddToFavoriteUsecase(summaryRepository: repository);
    unfavoriteUsecase = UnfavoriteUsecase(summaryRepository: repository);
    clearHistoryUsecase = ClearHistoryUsecase(summaryRepository: repository);
    getHistoryUsecase = GetHistoryUsecase(summaryRepository: repository);
  });

  test('getSummaryUsecase', () async {
    when(repository.getSummary(payload: dummySummaryPayload)).thenAnswer(
      (realInvocation) async => Right(dummyFavoriteSummary),
    );
    final result = await getSummaryUsecase.call(dummySummaryPayload);
    expect(result, isA<Right>());
  });

  test('addToFavorite', () async {
    when(repository.addToFavorite(summary: dummySummary)).thenAnswer(
      (realInvocation) async => Right(true),
    );
    final result = await addToFavoriteUsecase.call(dummySummary);
    expect(result, isA<Right>());
  });

  test('unfavorite', () async {
    when(repository.unfavorite(summary: dummySummary)).thenAnswer(
      (realInvocation) async => Right(true),
    );
    final result = await unfavoriteUsecase.call(dummySummary);
    expect(result, isA<Right>());
  });

  test('clearHistory', () async {
    when(repository.clearHistory()).thenAnswer(
      (realInvocation) async => Right(true),
    );
    final result = await clearHistoryUsecase.call(NoParams());
    expect(result, isA<Right>());
  });

  test('getHistory', () async {
    when(repository.getHistory()).thenAnswer(
      (realInvocation) async => Right([]),
    );
    final result = await getHistoryUsecase.call(NoParams());
    expect(result, isA<Right>());
  });

  test('should return GetSummaryPayload props', () async {
    expect(dummySummaryPayload.props, [dummySummary.originalText, false]);
  });
}
