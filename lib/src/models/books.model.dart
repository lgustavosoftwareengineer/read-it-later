import 'book.model.dart';

class Books {
  String responseCode;
  String kind;
  int totalItems;
  List<Book> items;

  Books({
    this.responseCode,
    this.kind,
    this.totalItems,
    this.items,
  });

  factory Books.createBooks(Map<String, dynamic> json) {
    return Books(
      responseCode: json['responseCode'],
      kind: json['kind'],
      totalItems: json['totalItems'],
      items: (json['items'] as List)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
