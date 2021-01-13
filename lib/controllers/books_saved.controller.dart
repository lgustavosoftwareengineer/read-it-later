import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:read_it_later/models/Book.dart';

class BooksSavedController extends ChangeNotifier {
  final List<Book> _items = [];

  UnmodifiableListView<Book> get items => UnmodifiableListView(_items);
  static BooksSavedController instance = BooksSavedController();

  void add(Book item) {
    _items.add(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  void removeOneItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  // List<Book> showAll() {
  //   notifyListeners();
  //   return _items;
  // }

  List<Book> showTrash() {}
}
