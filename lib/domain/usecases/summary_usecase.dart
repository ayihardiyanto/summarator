// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:summarator/common/errors/failure.dart';
import 'package:summarator/common/usecase/usecase.dart';
import 'package:summarator/domain/repos/summary_repository.dart';

@injectable
class GetSummaryUsecase extends Usecase<String, Map<String, dynamic>> {
  final ISummaryRepository summaryRepository;

  GetSummaryUsecase({required this.summaryRepository});
  @override
  Future<Either<Failure, String>> call(Map<String, dynamic> params) async {
    return await summaryRepository.getSummary(payload: params);
  }
}
