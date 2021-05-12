import 'package:flutter_test/flutter_test.dart';
import 'package:summarator/data/model/__mock__/summary_model_dummy.dart';
import 'package:summarator/presentation/screen/summarator/bloc/summarize_bloc.dart';

void main() {
  test('should return GetSummarization props', () {
    final actual = GetSummarization(text: dummySummary.originalText!);
    expect(actual.props, [dummySummary.originalText]);
  });

  test('should return GetSummarizationFromHistory props', () {
    final actual = GetSummarizationFromHistory(summary: dummySummary);
    expect(actual.props, [dummySummary]);
  });

  test('should return DismissSummary props', () {
    final actual = DismissSummary();
    expect(actual.props, []);
  });
}
