import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:read_it_later/src/models/book.model.dart';

Future<Book> fetchBook() async {
  final String myKey = '<chave-aqui>';
  final response = await http.get(
      'https://www.googleapis.com/books/v1/volumes/QW32DwAAQBAJ?key=$myKey');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(Book.fromJson(jsonDecode(response.body)));
    return Book.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Book');
  }
}

Future<Books> fetchBooks({String searchTerm}) async {
  final String myKey = '<chave-aqui>';
  final UriEncoded = Uri.encodeFull(
      "https://www.googleapis.com/books/v1/volumes?q=$searchTerm&key=$myKey&maxResults=40");
  
  print(UriEncoded);
  final response = await http.get(UriEncoded);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Books.createBooks(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Book');
  }
}
