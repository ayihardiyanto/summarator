import 'package:flutter_test/flutter_test.dart';
import 'package:summarator/data/model/__mock__/summary_model_dummy.dart';
import 'package:summarator/presentation/screen/summarator/bloc/history_bloc.dart';

void main() {
  test('should return HistoryInitial props', () {
    final actual = HistoryInitial();
    expect(actual.props, []);
  });

  test('should return HistoryLoading props', () {
    final actual = HistoryLoading();
    expect(actual.props, []);
  });

  test('should return HistoryError props', () {
    final actual = HistoryError();
    expect(actual.props, []);
  });

  test('should return HistoryCleared props', () {
    final actual = HistoryCleared();
    expect(actual.props, []);
  });

  test('should return HistoryLoaded props', () {
    final actual = HistoryLoaded(summaries: [dummySummary]);
    expect(actual.props, [[dummySummary]]);
  });
}
