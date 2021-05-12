import 'package:summarator/data/model/__mock__/summary_model_dummy.dart';
import 'package:summarator/domain/usecases/summary_usecase.dart';

GetSummaryPayload dummySummaryPayload = GetSummaryPayload(
  text: dummySummary.originalText!,
);

GetSummaryPayload dummySummaryPayloadTrue = GetSummaryPayload(
  text: dummySummary.originalText!,
  useClustering: true,
);
