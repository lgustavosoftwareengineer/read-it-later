import 'dart:convert';

BookSQLite BookSQLiteFromJson(String str) {
  final jsonData = json.decode(str);
  return BookSQLite.fromMap(jsonData);
}

String BookSQLiteToJson(BookSQLite data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class BookSQLite {
  final int id;
  final String bookId;
  final String title;
  final String authors;
  final String image;
  final String description;
  final String publishedDate;
  final String selfLink;

  BookSQLite({
    this.id,
    this.bookId,
    this.title,
    this.authors,
    this.image,
    this.description,
    this.publishedDate,
    this.selfLink,
  });

  factory BookSQLite.fromMap(Map<String, dynamic> json) => new BookSQLite(
        id: json['id'],
        bookId: json['bookId'],
        title: json['title'],
        authors: json['authors'],
        image: json['image'],
        description: json['description'],
        publishedDate: json['publishedDate'],
        selfLink: json['selfLink'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'bookId': bookId,
        'title': title,
        'authors': authors,
        'image': image,
        'description': description,
        'publishedDate': publishedDate,
        'selfLink': selfLink,
      };
}
