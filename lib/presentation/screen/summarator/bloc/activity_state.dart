part of 'activity_bloc.dart';

abstract class ActivityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ActivityInitial extends ActivityState {}

class Listening extends ActivityState {}

class Listened extends ActivityState {
  final String text;

  Listened({this.text = CommonConstants.emptyString});
  @override
  // TODO: implement props
  List<Object?> get props => [text];
}

class Paused extends ActivityState {}

class UpdatingFavorite extends ActivityState {}

class FavoriteUpdated extends ActivityState {
  final bool favorite;

  FavoriteUpdated({this.favorite = false});
}
