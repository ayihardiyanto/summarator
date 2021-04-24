import 'package:summarator/domain/entities/pdf_info_entity.dart';

class PDFInfoModel extends PDFInfo {
  PDFInfoModel({
    String? author,
    String? creator,
    String? title,
    String? subject,
    String? producer,
    String? path,
    List<String?>? keywords,
    List<String?>? authors,
    DateTime? creationDate,
    DateTime? modificationDate,
  }) : super(
          author: author,
          authors: authors,
          creator: creator,
          title: title,
          subject: subject,
          creationDate: creationDate,
          keywords: keywords,
          producer: producer,
          path: path,
        );
}
