// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:summarator/common/errors/failure.dart';
import 'package:summarator/common/usecase/usecase.dart';
import 'package:summarator/domain/entities/summary_entity.dart';
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
class GetSummaryUsecase extends Usecase<Summary, GetSummaryPayload> {
  final ISummaryRepository summaryRepository;

  GetSummaryUsecase({required this.summaryRepository});
  @override
  Future<Either<Failure, Summary>> call(GetSummaryPayload params) async {
    return await summaryRepository.getSummary(payload: params);
  }
}

@injectable
class AddToFavoriteUsecase extends Usecase<bool, Summary> {
  final ISummaryRepository summaryRepository;

  AddToFavoriteUsecase({required this.summaryRepository});
  @override
  Future<Either<Failure, bool>> call(Summary params) async {
    return await summaryRepository.addToFavorite(summary: params);
  }
}

@injectable
class UnfavoriteUsecase extends Usecase<bool, Summary> {
  final ISummaryRepository summaryRepository;

  UnfavoriteUsecase({required this.summaryRepository});
  @override
  Future<Either<Failure, bool>> call(Summary params) async {
    return await summaryRepository.unfavorite(summary: params);
  }
}

@injectable
class ClearHistoryUsecase extends Usecase<bool, NoParams> {
  final ISummaryRepository summaryRepository;

  ClearHistoryUsecase({required this.summaryRepository});
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await summaryRepository.clearHistory();
  }
}

@injectable
class GetHistoryUsecase extends Usecase<List<Summary>, NoParams> {
  final ISummaryRepository summaryRepository;

  GetHistoryUsecase({required this.summaryRepository});
  @override
  Future<Either<Failure, List<Summary>>> call(NoParams params) async {
    return await summaryRepository.getHistory();
  }
}
