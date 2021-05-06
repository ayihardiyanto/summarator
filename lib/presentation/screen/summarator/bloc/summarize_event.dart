part of 'summarize_bloc.dart';

abstract class SummarizeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSummarization extends SummarizeEvent {
  final String text;

  GetSummarization({required this.text});

  @override
  List<Object?> get props => [text];
}

class GetSummarizationFromHistory extends SummarizeEvent {
  final Summary summary;

  GetSummarizationFromHistory({required this.summary});

  @override
  List<Object?> get props => [summary];
}

class DismissSummary extends SummarizeEvent {}
