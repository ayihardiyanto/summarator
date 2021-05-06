import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:summarator/common/constants/common_constants.dart';
import 'package:summarator/common/constants/summary_constants.dart';
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
  bool isSummarized = false;
  ActivityBloc(
      {required this.addToFavoriteUsecase, required this.unfavoriteUsecase})
      : super(ActivityInitial());

  void addSubscription(SummarizeBloc summarizeBloc) {
    summarizeSubscription = summarizeBloc.stream.listen((state) {
      if (state is Summarized) {
        notifyListener(true);
      }
      if (state is SummaryDismissed) {
        notifyListener(false);
      }
    });
  }

  void notifyListener(summarized) {
    isSummarized = summarized;
    String text =
        isSummarized ? SummaryConstants.text : CommonConstants.emptyString;
    add(AttachListener(isSummarized: isSummarized, text: text));
  }

  @override
  Stream<ActivityState> mapEventToState(ActivityEvent event) async* {
    if (event is AttachListener) {
      yield Listening();
      if (event.text.isEmpty) {
        yield TextEmpty();
      } else {
        yield TextFilled(isSummarized: isSummarized);
      }
    }

    if (event is AddToFavorite) {
      yield UpdatingFavorite();
      await addToFavoriteUsecase.call(event.summary);
      yield FavoriteUpdated(favorite: true);
    }

    if (event is RemoveFavorite) {
      yield UpdatingFavorite();
      await unfavoriteUsecase.call(event.summary);
      yield FavoriteUpdated(favorite: false);
    }

    if (event is ResultBoxAddToFavorite) {
      yield UpdatingFavorite();
      await addToFavoriteUsecase.call(event.summary);
      yield FavoriteResultBoxUpdated(favorite: true);
    }

    if (event is ResultBoxRemoveFavorite) {
      yield UpdatingFavorite();
      await unfavoriteUsecase.call(event.summary);
      yield FavoriteResultBoxUpdated(favorite: false);
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    summarizeSubscription.cancel();
    return super.close();
  }
}
