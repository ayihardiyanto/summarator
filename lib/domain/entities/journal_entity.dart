import 'package:equatable/equatable.dart';

class Journal extends Equatable {
  final String? abstraction;
  final String? introduction;
  final String? conclusion;
  final String? shownText;
  final bool? summarized;
  final DateTime? addedDate;
  final DateTime? summarizedDate;

  Journal({
    this.abstraction,
    this.introduction,
    this.conclusion,
    this.shownText,
    this.summarized,
    this.addedDate,
    this.summarizedDate,
  });

  @override
  List<Object> get props => [
        abstraction!,
        introduction!,
        conclusion!,
        shownText!,
        summarized!,
        addedDate!,
        summarizedDate!,
      ];
}
