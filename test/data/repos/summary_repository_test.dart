import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:summarator/common/constants/summary_constants.dart';
import 'package:summarator/common/errors/bad_request.dart';
import 'package:summarator/common/errors/no_connection.dart';
import 'package:summarator/common/utils/network_check.dart';
import 'package:summarator/data/datasource/local/summary_local_datasource.dart';
import 'package:summarator/data/model/__mock__/summary_model_dummy.dart';
import 'package:summarator/data/repos/summary_repository.dart';
import 'package:summarator/domain/repos/summary_repository.dart';
import 'package:summarator/domain/usecases/summary_usecase.dart';
import 'summary_repository_test.mocks.dart';

@GenerateMocks([ISummaryRepository], customMocks: [
  MockSpec<NetworkCheck>(returnNullOnMissingStub: true),
  MockSpec<SummaryLocalDatasource>(returnNullOnMissingStub: true),
])
void main() {
  late SummaryLocalDatasource summaryLocalDatasource;
  late ISummaryRepository summaryRepository;
  late Dio dio;
  late DioAdapter dioAdapter;
  late NetworkCheck networkCheck;
  setUp(() {
    summaryLocalDatasource = MockSummaryLocalDatasource();
    networkCheck = MockNetworkCheck();
    dioAdapter = DioAdapter();
    dio = Dio()..httpClientAdapter = dioAdapter;
    summaryRepository = SummaryRepository(
      networkCheck: networkCheck,
      dio: dio,
      localDatasource: summaryLocalDatasource,
    );
  });

  group('getSummary', () {
    test('should return valid data from local', () async {
      when(networkCheck.isOnline()).thenAnswer((realInvocation) async => true);
      when(summaryLocalDatasource.getFormattedItem(SummaryConstants.history +
              dummySummary.originalText! +
              dummySummary.originalText!))
          .thenAnswer((realInvocation) async => dummySummary);
      final result = await summaryRepository.getSummary(
          payload: GetSummaryPayload(text: dummySummary.originalText!));
      expect(result, isA<Right>());
    });

    test('should return valid data from remote', () async {
      final data = {SummaryConstants.result: dummySummary.summarizedText};
      dioAdapter.onPost(
        'http://192.168.43.221:8080',
        (request) => request.reply(200, data),
        data: {
          SummaryConstants.text: dummySummary.originalText,
          SummaryConstants.useClustering: false,
        },
      );
      when(networkCheck.isOnline()).thenAnswer((realInvocation) async => true);
      when(summaryLocalDatasource.getFormattedItem(SummaryConstants.history +
              dummySummary.originalText! +
              dummySummary.originalText!))
          .thenAnswer((realInvocation) async => null);
      final result = await summaryRepository.getSummary(
          payload: GetSummaryPayload(text: dummySummary.originalText!));
      expect(result, isA<Right>());
    });

    test('should return Left when NoConnectionError', () async {
      when(summaryLocalDatasource.getFormattedItem(SummaryConstants.history +
              dummySummary.originalText! +
              dummySummary.originalText!))
          .thenAnswer((realInvocation) async => null);
      when(networkCheck.isOnline()).thenAnswer((realInvocation) async => false);
      final result = await summaryRepository.getSummary(
          payload: GetSummaryPayload(text: dummySummary.originalText!));
      expect(result, Left(NoConnectionError()));
    });

    test('should return Left when BadRequest', () async {
      when(networkCheck.isOnline()).thenAnswer((realInvocation) async => false);
      final result = await summaryRepository.getSummary(
          payload: GetSummaryPayload(text: dummySummary.originalText!));
      expect(result, Left(BadRequest()));
    });
  });

  group('addToFavorite', () {
    test('should return Right when success', () async {
      final result =
          await summaryRepository.addToFavorite(summary: dummySummary);
      expect(result, Right(true));
    });

    test('should return Left when failed', () async {
      final result =
          await summaryRepository.addToFavorite(summary: dummyInvalidSummary);
      expect(result, Left(BadRequest()));
    });
  });

  group('unfavorite', () {
    test('should return Right when success', () async {
      final result = await summaryRepository.unfavorite(
        summary: dummyFavoriteSummary,
      );
      expect(result, Right(true));
    });

    test('should return Left when failed', () async {
      final result = await summaryRepository.unfavorite(
        summary: dummyInvalidSummary,
      );
      expect(result, Left(BadRequest()));
    });
  });

  group('clearHistory', () {
    test('should return true Right when success', () async {
      when(summaryLocalDatasource.getFormattedData())
          .thenAnswer((realInvocation) async => [dummyFavoriteSummary]);
      final result = await summaryRepository.clearHistory();
      expect(result, Right(true));
    });


    test('should return false Right when success', () async {
      when(summaryLocalDatasource.getFormattedData())
          .thenAnswer((realInvocation) async => []);
      final result = await summaryRepository.clearHistory();
      expect(result, Right(false));
    });

    test('should return Left when failed', () async {
      final result = await summaryRepository.clearHistory();
      expect(result, Left(BadRequest()));
    });
  });

  group('getHistory', () {
    test('should return Right when success', () async {
      when(summaryLocalDatasource.getFormattedData())
          .thenAnswer((realInvocation) async => [dummySummary]);
      final result = await summaryRepository.getHistory();
      expect(result, isA<Right>());
    });

    test('should return Left when failed', () async {
      final result = await summaryRepository.getHistory();
      expect(result, Left(BadRequest()));
    });
  });
}
