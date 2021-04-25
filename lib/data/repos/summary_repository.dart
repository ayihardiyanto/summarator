// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:summarator/common/constants/summary_constants.dart';
import 'package:summarator/common/errors/bad_request.dart';
import 'package:summarator/common/errors/failure.dart';
import 'package:summarator/common/errors/no_connection.dart';
import 'package:summarator/common/utils/logger.dart';
import 'package:summarator/common/utils/network_check.dart';
import 'package:summarator/domain/repos/summary_repository.dart';
import 'package:summarator/domain/usecases/summary_usecase.dart';

@LazySingleton(as: ISummaryRepository)
class SummaryRepository implements ISummaryRepository {
  final NetworkCheck networkCheck;
  final Dio dio;

  SummaryRepository({required this.networkCheck, required this.dio});
  @override
  Future<Either<Failure, String>> getSummary(
      {required GetSummaryPayload payload}) async {
    try {
      if (await networkCheck.isOnline()) {
        final Map<String, dynamic> param = {
          SummaryConstants.text: payload.text,
          SummaryConstants.useClustering: false,
        };
        final result = await dio.post('http://192.168.43.221:8080', data: param);
        return Right(result.data[SummaryConstants.result]);
      }
      return Left(NoConnectionError());
    } catch (e) {
      Log.e('getSummary ERROR: $e');
      return Left(BadRequest());
    }
  }
}
