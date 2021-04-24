import 'dart:convert';

import 'package:summarator/common/constants/journal_constants.dart';
import 'package:summarator/domain/entities/journal_entity.dart';

class JournalModel extends Journal {
  JournalModel({
    String? abstraction,
    String? introduction,
    String? conclusion,
    String? shownText,
    bool? summarized,
    DateTime? addedDate,
    DateTime? summarizedDate,
  }) : super(
          abstraction: abstraction,
          introduction: introduction,
          conclusion: conclusion,
          shownText: shownText,
          summarized: summarized,
          addedDate: addedDate,
          summarizedDate: summarizedDate,
        );

  factory JournalModel.fromJson({dynamic json}) {
    return JournalModel(
        abstraction: json[JournalConstants.abstraction],
        addedDate: json[JournalConstants.addedDate],
        conclusion: json[JournalConstants.conclusion],
        introduction: json[JournalConstants.introduction],
        shownText: json[JournalConstants.shownText],
        summarized: json[JournalConstants.summarized],
        summarizedDate: json[JournalConstants.summarizedDate]);
  }

  Map<String, dynamic> toJson() {
    return {
      JournalConstants.abstraction: abstraction,
      JournalConstants.addedDate: addedDate,
      JournalConstants.conclusion: conclusion,
      JournalConstants.introduction: introduction,
      JournalConstants.shownText: shownText,
      JournalConstants.summarized: summarized,
      JournalConstants.summarizedDate: summarizedDate,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
