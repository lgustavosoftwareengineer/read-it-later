import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:read_it_later/models/BookFromSQLite.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Books ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "bookId TEXT,"
          "title TEXT,"
          "authors TEXT,"
          "image TEXT,"
          "description TEXT,"
          "publishedDate TEXT,"
          "selfLink TEXT"
          ")");

      await db.execute("CREATE TABLE Trash ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "bookId TEXT,"
          "title TEXT,"
          "authors TEXT,"
          "image TEXT,"
          "description TEXT,"
          "publishedDate TEXT,"
          "selfLink TEXT"
          ")");
    });
  }

  Future<int> newBook(BookSQLite book) async {
    final db = await database;
    var res = await db.insert("Books", book.toMap());
    print(res);
    return res;
  }

  Future<int> newBookInTrash(BookSQLite book) async {
    final db = await database;
    var res = await db.insert("Trash", book.toMap());
    return res;
  }

  // GET METHODS
  Future<BookSQLite> getBook(int id) async {
    final db = await database;
    var res = await db.query("Books", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? BookSQLite.fromMap(res.first) : Null;
  }

  Future<List<BookSQLite>> getAllBooks() async {
    final db = await database;
    var res = await db.query("Books");
    List<BookSQLite> list =
        res.isNotEmpty ? res.map((c) => BookSQLite.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<BookSQLite>> getAllBooksFromTrash() async {
    final db = await database;
    var res = await db.query("Trash");
    List<BookSQLite> list =
        res.isNotEmpty ? res.map((c) => BookSQLite.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> deleteAllBooks() async {
    final db = await database;
    return db.rawDelete("Delete * from Books");
  }

  Future<int> sendBookFromTrash(int id) async {
    final db = await database;
    final res = await getBook(id);
    await newBookInTrash(res);
    return await db.delete("Books", where: "id = ?", whereArgs: [id]);
  }

  Future<int> removePermanentilyTheBook(int id) async {
    final db = await database;
    return db.delete("Trash", where: "id = ?", whereArgs: [id]);
  }
}
