part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttachListener extends ActivityEvent {}

class PauseUponSummarizing extends ActivityEvent {}

class AddToFavorite extends ActivityEvent {
  final Summary summary;

  AddToFavorite({ required this.summary});
  @override
  // TODO: implement props
  List<Object?> get props => [summary];
}

class RemoveFavorite extends ActivityEvent {
  final Summary summary;

  RemoveFavorite({ required this.summary});
  @override
  // TODO: implement props
  List<Object?> get props => [summary];
}
