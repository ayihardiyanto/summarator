// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:summarator/common/constants/common_constants.dart';
import 'package:summarator/common/constants/summary_constants.dart';
import 'package:summarator/common/errors/bad_request.dart';
import 'package:summarator/common/errors/failure.dart';
import 'package:summarator/common/errors/no_connection.dart';
import 'package:summarator/common/utils/logger.dart';
import 'package:summarator/common/utils/network_check.dart';
import 'package:summarator/data/datasource/local/summary_local_datasource.dart';
import 'package:summarator/data/model/summary_model.dart';
import 'package:summarator/domain/entities/summary_entity.dart';
import 'package:summarator/domain/repos/summary_repository.dart';
import 'package:summarator/domain/usecases/summary_usecase.dart';
import 'package:summarator/env.dart';

@LazySingleton(as: ISummaryRepository)
class SummaryRepository implements ISummaryRepository {
  final NetworkCheck networkCheck;
  final Dio dio;
  final SummaryLocalDatasource localDatasource;

  SummaryRepository({
    required this.networkCheck,
    required this.dio,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, SummaryModel>> getSummary({
    required GetSummaryPayload payload,
  }) async {
    final wordArray = payload.text.split(CommonConstants.space);
    final keyword = SummaryConstants.history +
        wordArray[0] +
        wordArray[wordArray.length - 1];
    try {
      final SummaryModel? localData =
          await localDatasource.getFormattedItem(keyword);
      if (await networkCheck.isOnline() && localData == null) {
        final Map<String, dynamic> param = {
          SummaryConstants.text: payload.text,
          SummaryConstants.useClustering: payload.useClustering,
        };
        final result =
            await dio.post(environment[CommonConstants.baseUrl]!, data: param);
        final returnValue = SummaryModel(
          key: keyword,
          favorite: false,
          originalText: payload.text,
          summarizedText: result.data[SummaryConstants.result],
        );
        await localDatasource.insertOrUpdateItem(
          returnValue,
          keyword,
        );
        return Right(returnValue);
      } else if (localData != null) {
        return Right(localData);
      }
      return Left(NoConnectionError());
    } catch (e) {
      Log.e('getSummary ERROR: $e');
      return Left(BadRequest());
    }
  }

  @override
  Future<Either<Failure, bool>> addToFavorite(
      {required Summary summary}) async {
    // TODO: implement addToFavorite
    try {
      final keyword = summary.key!;
      final newKeyword = SummaryConstants.favorite + keyword;
      await shiftSummaryInStorage(summary, newKeyword, true);
      return Right(true);
    } catch (e) {
      return Left(BadRequest());
    }
  }

  @override
  Future<Either<Failure, bool>> clearHistory() async {
    try {
      final List<SummaryModel> localData =
          await localDatasource.getFormattedData();
      if (localData.isEmpty) {
        return Right(false);
      }
      await localDatasource.deleteAll();
      for (SummaryModel data in localData) {
        if (data.key!.contains(SummaryConstants.favorite)) {
          String keyword = data.key!.replaceAll(
              SummaryConstants.history, CommonConstants.emptyString);
          await shiftSummaryInStorage(data, keyword, true);
        }
      }
      return Right(true);
    } catch (e) {
      return Left(BadRequest());
    }
  }

  @override
  Future<Either<Failure, bool>> unfavorite({required Summary summary}) async {
    try {
      final keyword = summary.key!;
      final newKeyword = keyword.split(SummaryConstants.favorite)[1];
      await shiftSummaryInStorage(summary, newKeyword, false);
      return Right(true);
    } catch (e) {
      return Left(BadRequest());
    }
  }

  @override
  Future<Either<Failure, List<SummaryModel>>> getHistory() async {
    try {
      final localData = await localDatasource.getFormattedData();
      return Right(localData);
    } catch (e) {
      return Left(BadRequest());
    }
  }

  Future<void> shiftSummaryInStorage(
      Summary summary, String newKeyword, bool favorite) async {
    final SummaryModel favorited = SummaryModel(
      key: newKeyword,
      favorite: favorite,
      originalText: summary.originalText,
      summarizedText: summary.summarizedText,
    );
    await localDatasource.insertOrUpdateItem(
      favorited,
      newKeyword,
    );
    await localDatasource.delete(summary.key!);
  }
}
