import 'package:summarator/data/datasource/local/databases/summary_table.dart';
import 'package:summarator/domain/entities/summary_entity.dart';

class SummaryModel extends Summary {
  SummaryModel({
    String? originalText,
    String? summarizedText,
    bool favorite = false,
  }) : super(
          originalText: originalText,
          summarizedText: summarizedText,
          favorite: favorite,
        );

  factory SummaryModel.fromTable({required SummaryTable table}) {
    return SummaryModel(
      originalText: table.originalText,
      summarizedText: table.summarizedText,
      favorite: table.favorite,
    );
  }
}
