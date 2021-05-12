import 'package:flutter_test/flutter_test.dart';
import 'package:summarator/presentation/screen/summarator/bloc/activity_bloc.dart';

void main() {
  test('should return ActivityInitial props', () {
    final actual = ActivityInitial();
    expect(actual.props, []);
  });

  test('should return Listening props', () {
    final actual = Listening();
    expect(actual.props, []);
  });

  test('should return TextEmpty props', () {
    final actual = TextEmpty();
    expect(actual.props, []);
  });

  test('should return ButtonHidden props', () {
    final actual = ButtonHidden();
    expect(actual.props, []);
  });

  test('should return UpdatingFavorite props', () {
    final actual = UpdatingFavorite();
    expect(actual.props, []);
  });

  test('should return TextFilled props', () {
    final actual = TextFilled(isSummarized: true);
    expect(actual.props, [true]);
  });

  test('should return FavoriteUpdated props', () {
    final actual = FavoriteUpdated(favorite: true);
    expect(actual.props, [true]);
  });

  test('should return FavoriteResultBoxUpdated props', () {
    final actual = FavoriteResultBoxUpdated(favorite: true);
    expect(actual.props, [true]);
  });
}
