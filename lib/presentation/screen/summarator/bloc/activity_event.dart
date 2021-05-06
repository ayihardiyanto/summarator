part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttachListener extends ActivityEvent {
  final String text;
  final bool isSummarized;

  AttachListener({this.text = CommonConstants.emptyString, this.isSummarized = false});
  @override
  // TODO: implement props
  List<Object?> get props => [text];
}

class AddToFavorite extends ActivityEvent {
  final Summary summary;

  AddToFavorite({required this.summary});
  @override
  // TODO: implement props
  List<Object?> get props => [summary];
}

class RemoveFavorite extends ActivityEvent {
  final Summary summary;

  RemoveFavorite({required this.summary});
  @override
  // TODO: implement props
  List<Object?> get props => [summary];
}

class ResultBoxAddToFavorite extends ActivityEvent {
  final Summary summary;

  ResultBoxAddToFavorite({required this.summary});
  @override
  // TODO: implement props
  List<Object?> get props => [summary];
}

class ResultBoxRemoveFavorite extends ActivityEvent {
  final Summary summary;

  ResultBoxRemoveFavorite({required this.summary});
  @override
  // TODO: implement props
  List<Object?> get props => [summary];
}
