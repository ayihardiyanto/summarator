import 'package:equatable/equatable.dart';

class PDFInfo extends Equatable {
  final String? author, creator, title, subject, producer, path;
  final List<String?>? keywords, authors;
  final DateTime? creationDate, modificationDate;

  PDFInfo({
    this.author,
    this.authors,
    this.creator,
    this.title,
    this.subject,
    this.creationDate,
    this.keywords,
    this.modificationDate,
    this.producer,
    this.path,
  });

  @override
  List<Object> get props => [
        author!,
        authors!,
        creator!,
        title!,
        subject!,
        creationDate!,
        keywords!,
        producer!,
        path!,
      ];
}
