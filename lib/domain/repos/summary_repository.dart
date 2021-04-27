// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:summarator/common/errors/failure.dart';
import 'package:summarator/data/model/summary_model.dart';
import 'package:summarator/domain/entities/summary_entity.dart';
import 'package:summarator/domain/usecases/summary_usecase.dart';

abstract class ISummaryRepository {
  Future<Either<Failure, SummaryModel>> getSummary({
    required GetSummaryPayload payload,
  });

  Future<Either<Failure, bool>> addToFavorite({
    required Summary summary,
  });

  Future<Either<Failure, bool>> unfavorite({
    required Summary summary,
  });

  Future<Either<Failure, bool>> clearHistory();


  Future<Either<Failure, List<SummaryModel>>> getHistory();
}
