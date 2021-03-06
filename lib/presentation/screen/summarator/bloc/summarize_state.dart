part of 'summarize_bloc.dart';

abstract class SummarizeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Summarized extends SummarizeState {
  final Summary? result;
  final bool summaryShown;

  Summarized({
    this.result,
    this.summaryShown = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        result,
        summaryShown,
      ];
}

class Summarizing extends SummarizeState {}

class SummarizingError extends SummarizeState {}

class SummarizingInitial extends SummarizeState {}

class SummaryDismissed extends SummarizeState {}
