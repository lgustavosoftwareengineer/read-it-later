import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:read_it_later/models/Book.dart';

class BooksSavedController extends ChangeNotifier {
  final List<Book> _items = [];

  UnmodifiableListView<Book> get items => UnmodifiableListView(_items);
  static BooksSavedController instance = BooksSavedController();

  void add(Book item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeOneItem(int index) {
    _items.removeAt(index);
  }

  List<Book> showAll() {
    return _items;
  }

  List<Book> showTrash() {}
}

final booksSavedController = BooksSavedController.instance;
