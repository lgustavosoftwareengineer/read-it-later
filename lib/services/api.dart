import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:read_it_later/models/Book.dart';
import '../config.dart';

Future<Books> fetchBooks({String searchTerm}) async {
  final UriEncoded = Uri.encodeFull(
      "https://www.googleapis.com/books/v1/volumes?q=$searchTerm&key=$myKey&maxResults=40");

  final response = await http.get(UriEncoded);
  if (response.statusCode == 200) {
    print(response.body);
    return Books.fromJson(jsonDecode(response.body));
  } else {
      throw Exception('Failed to load Books');
  }
}

Future<Book> fetchBook({String link}) async {
  
    final UriEncoded = Uri.encodeFull(link);

    final response = await http.get(UriEncoded);

    if (response.statusCode == 200) {
      final Book bookFromJson = Book.fromJson(jsonDecode(response.body));
      return bookFromJson;
    } else {
      throw Exception('Failed to load Book');
    }
}
