import 'package:summarator/common/constants/common_values_for_test.dart';
import 'package:summarator/common/constants/summary_constants.dart';
import 'package:summarator/data/model/summary_model.dart';

SummaryModel dummySummary = SummaryModel(
  favorite: false,
  key: CommonValuesForTest.dummyKey,
  originalText: CommonValuesForTest.dummyText,
  summarizedText: CommonValuesForTest.dummyText,
);

SummaryModel dummyInvalidSummary = SummaryModel(
  favorite: false,
  originalText: CommonValuesForTest.dummyText,
  summarizedText: CommonValuesForTest.dummyText,
);

SummaryModel dummyFavoriteSummary = SummaryModel(
  favorite: false,
  originalText: CommonValuesForTest.dummyText,
  key: SummaryConstants.favorite + SummaryConstants.history + CommonValuesForTest.dummyKey,
  summarizedText: CommonValuesForTest.dummyText,
);
