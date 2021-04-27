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

class DismissSummary extends SummarizeEvent {}

