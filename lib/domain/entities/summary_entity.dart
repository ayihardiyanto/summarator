import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class Summary extends Equatable {
  @HiveField(0)
  final String? originalText;
  @HiveField(1)
  final String? summarizedText;
  @HiveField(2)
  final bool favorite;

  Summary({this.originalText, this.summarizedText, this.favorite = false});

  @override
  // TODO: implement props
  List<Object?> get props => [
        originalText,
        summarizedText,
        favorite,
      ];
}
