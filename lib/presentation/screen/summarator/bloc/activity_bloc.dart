import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pedantic/pedantic.dart';
import 'package:summarator/domain/entities/summary_entity.dart';
import 'package:summarator/domain/usecases/summary_usecase.dart';
import 'package:summarator/presentation/screen/summarator/bloc/summarize_bloc.dart';

part 'activity_event.dart';

part 'activity_state.dart';

@injectable
class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  late StreamSubscription summarizeSubscription;
  final AddToFavoriteUsecase addToFavoriteUsecase;
  final UnfavoriteUsecase unfavoriteUsecase;
  ActivityBloc(
      {required this.addToFavoriteUsecase, required this.unfavoriteUsecase})
      : super(ActivityInitial());

  void addSubscription(SummarizeBloc summarizeBloc) {
    summarizeSubscription = summarizeBloc.stream.listen((state) {
      if (state is Summarized) {
        add(PauseUponSummarizing());
      }
    });
  }

  @override
  Stream<ActivityState> mapEventToState(ActivityEvent event) async* {
    if (event is AttachListener) {
      yield Listening();
      yield Listened();
    }

    if (event is PauseUponSummarizing) {
      yield Paused();
    }

    if (event is AddToFavorite) {
      yield UpdatingFavorite();
      unawaited(addToFavoriteUsecase.call(event.summary));
      yield FavoriteUpdated(favorite: true);
    }

    if (event is RemoveFavorite) {
      yield UpdatingFavorite();
      unawaited(unfavoriteUsecase.call(event.summary));
      yield FavoriteUpdated(favorite: false);
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    summarizeSubscription.cancel();
    return super.close();
  }
}
