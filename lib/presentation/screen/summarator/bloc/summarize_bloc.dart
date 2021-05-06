import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:summarator/domain/entities/summary_entity.dart';
import 'package:summarator/domain/usecases/summary_usecase.dart';

part 'summarize_event.dart';
part 'summarize_state.dart';

@injectable
class SummarizeBloc extends Bloc<SummarizeEvent, SummarizeState> {
  final GetSummaryUsecase getSummaryUsecase;
  SummarizeBloc({required this.getSummaryUsecase})
      : super(SummarizingInitial());

  @override
  Stream<SummarizeState> mapEventToState(SummarizeEvent event) async* {
    if (event is GetSummarization) {
      yield Summarizing();
      final result = await getSummaryUsecase
          .call(GetSummaryPayload(text: event.text, useClustering: true));
      yield* result.fold((l) async* {
        yield SummarizingError();
      }, (r) async* {
        yield Summarized(result: r, summaryShown: true);
      });
    }
    if (event is GetSummarizationFromHistory) {
      yield Summarizing();
      yield Summarized(result: event.summary, summaryShown: true);
    }
    if (event is DismissSummary) {
      yield SummaryDismissed();
    }
  }
}
