import 'package:flutter_test/flutter_test.dart';
import 'package:summarator/presentation/screen/summarator/bloc/history_bloc.dart';

void main() {
  test('should return HistoryEvent props', () {
    final actual = GetHistory();
    expect(actual.props, []);
  });

  test('should return ClearHistory props', () {
    final actual = ClearHistory();
    expect(actual.props, []);
  });
}
