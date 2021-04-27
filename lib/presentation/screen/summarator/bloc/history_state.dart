part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryError extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Summary> summary;

  HistoryLoaded({this.summary = const []});
  @override
  // TODO: implement props
  List<Object?> get props => [summary];
}
