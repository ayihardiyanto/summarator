import 'package:flutter_test/flutter_test.dart';
import 'package:summarator/common/constants/common_values_for_test.dart';
import 'package:summarator/domain/entities/summary_entity.dart';

void main() {
  test('should return Summary props', () {
    final actual = Summary(
      favorite: false,
      key: CommonValuesForTest.dummyKey,
      originalText: CommonValuesForTest.dummyText,
      summarizedText: CommonValuesForTest.dummyText,
    );
    expect(actual.props, [
      CommonValuesForTest.dummyText,
      CommonValuesForTest.dummyText,
      false,
      CommonValuesForTest.dummyKey,
    ]);
  });
}
