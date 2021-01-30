import 'package:flutter/material.dart';
import 'package:read_it_later/models/BookFromHttpRequest.dart';
import 'package:read_it_later/models/BookFromSQLite.dart';
import 'package:read_it_later/services/DBProvider.dart';

class HomeController extends ChangeNotifier {
  String completedBooksTable = 'CompletedBooks';
  String nextReadingTable = 'NextReading';
  String nowReadingTable = 'NowReading';

  Future<List<BookSQLite>> get nowReading =>
      DBProvider.db.getAll(nowReadingTable);


  static HomeController instance = HomeController();
  

  addBookInNowReading({BookFromHttpRequest item}) {
    DBProvider.db.newItem(
        new BookSQLite(
            title: item.title,
            authors: item.authors,
            bookId: item.id,
            description: item.description,
            image: item.image,
            publishedDate: item.publishedDate,
            selfLink: item.selfLink),
        nowReadingTable);
    notifyListeners();
  }


  deleteBookInNowReading(int id) async {
    await DBProvider.db.deleteOne(id, nowReadingTable);
    notifyListeners();
  }

  removeAllBooksInNowReading() async {
    await DBProvider.db.deleteAll(nowReadingTable);
    notifyListeners();
  }

}
