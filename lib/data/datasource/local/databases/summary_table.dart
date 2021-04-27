import 'package:hive/hive.dart';
import 'package:summarator/common/constants/local_database_type_constant.dart';
import 'package:summarator/data/model/summary_model.dart';

part 'summary_table.g.dart';

@HiveType(typeId: HiveTypeIdConstants.summary)
class SummaryTable extends SummaryModel {
  SummaryTable({
    String? originalText,
    String? summarizedText,
    bool favorite = false,
  }) : super(
          originalText: originalText,
          summarizedText: summarizedText,
          favorite: favorite,
        );

  factory SummaryTable.fromModel({required SummaryModel model}) => SummaryTable(
        originalText: model.originalText!,
        summarizedText: model.summarizedText!,
        favorite: model.favorite,
      );
}