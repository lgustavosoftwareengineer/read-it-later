class Book {
  final String id;
  final String title;
  final String authors;
  final String image;
  final String description;
  final String publishedDate;

  Book(
      {this.authors,
      this.id,
      this.title,
      this.image,
      this.description,
      this.publishedDate});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['volumeInfo']['title'],
      authors: json['volumeInfo']['authors'][0],
      image: json['volumeInfo']['imageLinks']['smallThumbnail'],
      description: json['volumeInfo']['description'],
      publishedDate: json['volumeInfo']['publishedDate'],
    );
  }
}

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

