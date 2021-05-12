import 'package:flutter_test/flutter_test.dart';
import 'package:summarator/data/model/__mock__/summary_model_dummy.dart';
import 'package:summarator/presentation/screen/summarator/bloc/summarize_bloc.dart';

void main() {
  test('should return Summarized props', () {
    final actual = Summarized(result: dummySummary);
    expect(actual.props, [dummySummary, false]);
  });

  test('should return Summarizing props', () {
    final actual = Summarizing();
    expect(actual.props, []);
  });

  test('should return SummarizingError props', () {
    final actual = SummarizingError();
    expect(actual.props, []);
  });

  test('should return SummarizingInitial props', () {
    final actual = SummarizingInitial();
    expect(actual.props, []);
  });

  test('should return SummaryDismissed props', () {
    final actual = SummaryDismissed();
    expect(actual.props, []);
  });
}
