part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetHistory extends HistoryEvent {}

class ClearHistory extends HistoryEvent {}
