class Book {
  final String id;
  final String title;
  final String authors;
  final String image;
  final String description;
  final String publishedDate;
  final String selfLink;

  Book(
      {this.authors = "",
      this.id = "",
      this.title = "",
      this.image =
          "https://png.pngtree.com/element_our/20190528/ourlarge/pngtree-blue-open-book-image_1134778.jpg",
      this.description = "",
      this.publishedDate = "",
      this.selfLink = ""});

  // ignore: missing_return
  factory Book.fromJson(Map<String, dynamic> json) {
    try {
      if (json['volumeInfo']['imageLinks']['smallThumbnail'] == null) {
      print('É nulo');
    }
    return Book(
      id: json['id'],
      selfLink: json['selfLink'],
      title: json['volumeInfo']['title'],
      authors: json['volumeInfo']['authors'][0],
      image: json['volumeInfo']['imageLinks']['smallThumbnail'],
      description: json['volumeInfo']['description'],
      publishedDate: json['volumeInfo']['publishedDate'],
    );
    } catch (err) {
      return Book(
      id: '',
      selfLink: '',
      title: 'Erro ao retornar o livro',
      authors: '',
      image: 'https://png.pngtree.com/element_our/20190528/ourlarge/pngtree-blue-open-book-image_1134778.jpg',
      description: '',
      publishedDate: '',
    );
    }
    
  }
}

class Books {
  String responseCode;
  String kind;
  int totalItems;
  List<Book> items;

  Books({
    this.responseCode = "",
    this.kind = "",
    this.totalItems = 0,
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
