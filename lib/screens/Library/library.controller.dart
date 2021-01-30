import 'package:flutter/material.dart';
import 'package:read_it_later/models/BookFromHttpRequest.dart';
import 'package:read_it_later/models/BookFromSQLite.dart';
import 'package:read_it_later/services/DBProvider.dart';

class LibraryController extends ChangeNotifier {
  String completedBooksTable = 'CompletedBooks';
  String nextReadingTable = 'NextReading';
  
  Future<List<BookSQLite>> get completedItems =>
      DBProvider.db.getAll(completedBooksTable);
  Future<List<BookSQLite>> get nextReading =>
      DBProvider.db.getAll(nextReadingTable);

  static LibraryController instance = LibraryController();


  addBookInNextReading({BookFromHttpRequest item}) {
    DBProvider.db.newItem(
        new BookSQLite(
            title: item.title,
            authors: item.authors,
            bookId: item.id,
            description: item.description,
            image: item.image,
            publishedDate: item.publishedDate,
            selfLink: item.selfLink),
        nextReadingTable);
    notifyListeners();
  }

  addBookInCompletedBooks(String tableFrom, int id) async {
    var res = await DBProvider.db.getOne(id, tableFrom);
    await DBProvider.db.newItem(res, completedBooksTable);
    await DBProvider.db.deleteOne(id, tableFrom);
    notifyListeners();
  }

  deleteBookInNextReading(int id) async {
    await DBProvider.db.deleteOne(id, nextReadingTable);
    notifyListeners();
  }

  deleteBookInCompletedBooks(int id) async {
    await DBProvider.db.deleteOne(id, completedBooksTable);
    notifyListeners();
  }

  removeAllBooksInNextReading() async {
    await DBProvider.db.deleteAll(nextReadingTable);
    notifyListeners();
  }

  removeAllBooksInCompletedBooks() async {
    await DBProvider.db.deleteAll(completedBooksTable);
    notifyListeners();
  }
}
