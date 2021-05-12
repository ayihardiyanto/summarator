import 'package:flutter_test/flutter_test.dart';
import 'package:summarator/data/model/__mock__/summary_model_dummy.dart';
import 'package:summarator/presentation/screen/summarator/bloc/activity_bloc.dart';

void main() {
  test('should return AttachListener props', () {
    final actual = AttachListener(
      isSummarized: true,
      text: dummySummary.originalText!,
    );
    expect(actual.props, [dummySummary.originalText!, true]);
  });

  test('should return AddToFavorite props', () {
    final actual = AddToFavorite(summary: dummySummary);
    expect(actual.props, [dummySummary]);
  });

  test('should return RemoveFavorite props', () {
    final actual = RemoveFavorite(summary: dummySummary);
    expect(actual.props, [dummySummary]);
  });

  test('should return ResultBoxAddToFavorite props', () {
    final actual = ResultBoxAddToFavorite(summary: dummySummary);
    expect(actual.props, [dummySummary]);
  });

  test('should return ResultBoxRemoveFavorite props', () {
    final actual = ResultBoxRemoveFavorite(summary: dummySummary);
    expect(actual.props, [dummySummary]);
  });
}
