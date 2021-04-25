// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:summarator/common/errors/failure.dart';
import 'package:summarator/common/usecase/usecase.dart';
import 'package:summarator/domain/repos/summary_repository.dart';

class GetSummaryPayload extends Equatable {
  final String text;
  final bool useClustering;

  GetSummaryPayload({required this.text, this.useClustering = false});
  @override
  // TODO: implement props
  List<Object?> get props => [text, useClustering];
}

@injectable
class GetSummaryUsecase extends Usecase<String, GetSummaryPayload> {
  final ISummaryRepository summaryRepository;

  GetSummaryUsecase({required this.summaryRepository});
  @override
  Future<Either<Failure, String>> call(GetSummaryPayload params) async {
    return await summaryRepository.getSummary(payload: params);
  }
}
