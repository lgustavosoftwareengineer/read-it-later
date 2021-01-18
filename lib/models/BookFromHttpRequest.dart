
class BookFromHttpRequest {
  final String id;
  final String title;
  final String authors;
  final String image;
  final String description;
  final String publishedDate;
  final String selfLink;

  BookFromHttpRequest(
      {this.authors,
      this.id,
      this.title,
      this.image,
      this.description,
      this.publishedDate,
      this.selfLink});

  factory BookFromHttpRequest.fromJson(Map<String, dynamic> json) {
    try {
    return BookFromHttpRequest(
      id: json['id'],
      selfLink: json['selfLink'],
      title: json['volumeInfo']['title'],
      authors: json['volumeInfo']['authors'][0],
      image: json['volumeInfo']['imageLinks']['smallThumbnail'],
      description: json['volumeInfo']['description'],
      publishedDate: json['volumeInfo']['publishedDate'],
    );
    } catch (err) {
      return BookFromHttpRequest(
      id: '',
      selfLink: '',
      title: '[error]',
      authors: '',
      image: '',
      description: '',
      publishedDate: '',
    );
    }
    
  }
}

class BooksFromHttpRequest {
  String responseCode;
  String kind;
  int totalItems;
  List<BookFromHttpRequest> items;

  BooksFromHttpRequest({
    this.responseCode = "",
    this.kind = "",
    this.totalItems = 0,
    this.items,
  });

  factory BooksFromHttpRequest.fromJson(Map<String, dynamic> json) {
    return BooksFromHttpRequest(
      responseCode: json['responseCode'],
      kind: json['kind'],
      totalItems: json['totalItems'],
      items: (json['items'] as List)
          .map((e) => BookFromHttpRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
