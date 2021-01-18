import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:read_it_later/models/BookFromHttpRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BooksSavedController extends ChangeNotifier {
  final List<BookFromHttpRequest> _items = [];
  final List<BookFromHttpRequest> _trash = [];

  UnmodifiableListView<BookFromHttpRequest> get items => UnmodifiableListView(_items);
  UnmodifiableListView<BookFromHttpRequest> get trash => UnmodifiableListView(_trash);

  static BooksSavedController instance = BooksSavedController();

  void add(BookFromHttpRequest item) async {
    final prefs = await SharedPreferences.getInstance();
    _items.add(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  void sendToTrash(int index) {
    var removedItem = _items.removeAt(index);
    _trash.add(removedItem);
    notifyListeners();
  }

  void removePermanentily(int index) {
    _trash.removeAt(index);
    notifyListeners();
  }
}
