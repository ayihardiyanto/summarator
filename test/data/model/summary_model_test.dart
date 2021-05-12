import 'package:flutter_test/flutter_test.dart';
import 'package:summarator/common/constants/common_values_for_test.dart';
import 'package:summarator/data/datasource/local/databases/summary_table.dart';
import 'package:summarator/data/model/summary_model.dart';

void main() {
  group('SummaryModel', () {
    test('should return SummaryModel props', () {
      final actual = SummaryModel(
        favorite: false,
        key: CommonValuesForTest.dummyKey,
        originalText: CommonValuesForTest.dummyText,
        summarizedText: CommonValuesForTest.dummyText,
      );

      expect(actual.props, isNotEmpty);
    });

    test('should return SummaryModel props', () {
      final modelTable = SummaryTable(
        favorite: false,
        key: CommonValuesForTest.dummyKey,
        originalText: CommonValuesForTest.dummyText,
        summarizedText: CommonValuesForTest.dummyText,
      );
      final actual = SummaryModel.fromTable(table: modelTable);

      expect(actual.props, modelTable.props);
    });
  });
}
