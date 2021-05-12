part of 'activity_bloc.dart';

abstract class ActivityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ActivityInitial extends ActivityState {}

class Listening extends ActivityState {}

class TextFilled extends ActivityState {
  final bool isSummarized;

  TextFilled({this.isSummarized = false});
  // TODO: implement props
  @override
  List<Object?> get props => [isSummarized];
  
}

class TextEmpty extends ActivityState {}

class ButtonHidden extends ActivityState {}

class UpdatingFavorite extends ActivityState {}

class FavoriteUpdated extends ActivityState {
  final bool favorite;

  FavoriteUpdated({this.favorite = false});

  @override
  // TODO: implement props
  List<Object?> get props => [favorite];
}

class FavoriteResultBoxUpdated extends ActivityState {
  final bool favorite;

  FavoriteResultBoxUpdated({this.favorite = false});

  // TODO: implement props
  @override
  List<Object?> get props => [favorite];
}
