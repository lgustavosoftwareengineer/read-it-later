import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:read_it_later/models/BookFromHttpRequest.dart';
import 'package:read_it_later/models/BookFromSQLite.dart';
import 'package:read_it_later/services/DBProvider.dart';

class BooksRepository extends ChangeNotifier {
  Future<List<BookSQLite>> get items => DBProvider.db.getAllBooks();
  Future<List<BookSQLite>> get trash => DBProvider.db.getAllBooksFromTrash();

  static BooksRepository instance = BooksRepository();

  add({BookFromHttpRequest item}) {
    DBProvider.db.newBook(new BookSQLite(
        title: item.title,
        authors: item.authors,
        bookId: item.id,
        description: item.description,
        image: item.image,
        publishedDate: item.publishedDate,
        selfLink: item.selfLink));
    notifyListeners();
  }

  Future<BookSQLite> getOne(int id) {
    return DBProvider.db.getBook(id);
  }

  removeAll() {
    DBProvider.db.deleteAllBooks();
    notifyListeners();
  }

  removeAllFromTrash() {
    DBProvider.db.deleteAllTrash();
    notifyListeners();
  }

  sendToTrash(int id) {
    DBProvider.db.sendBookFromTrash(id);
    notifyListeners();
  }

  removePermanentily(int id) {
    DBProvider.db.removePermanentilyTheBook(id);
    notifyListeners();
  }
}
