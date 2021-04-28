import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pedantic/pedantic.dart';
import 'package:summarator/common/usecase/usecase.dart';
import 'package:summarator/common/utils/logger.dart';
import 'package:summarator/domain/entities/summary_entity.dart';
import 'package:summarator/domain/usecases/summary_usecase.dart';

part 'history_event.dart';
part 'history_state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistoryUsecase getHistoryUsecase;
  final ClearHistoryUsecase clearHistoryUsecase;
  HistoryBloc({
    required this.getHistoryUsecase,
    required this.clearHistoryUsecase,
  }) : super(HistoryInitial());

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetHistory) {
      final result = await getHistoryUsecase.call(NoParams());
      yield* result.fold((l) async* {
        Log.e('GetHistory Error: $l');
        yield HistoryError();
      }, (r) async* {
        yield HistoryLoaded(summaries: r);
      });
    }

    if (event is ClearHistory) {
      yield HistoryLoading();
      await clearHistoryUsecase.call(NoParams());
      add(GetHistory());
      yield HistoryCleared();
    }
  }
}
