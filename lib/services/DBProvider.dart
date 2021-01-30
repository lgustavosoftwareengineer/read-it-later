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
      await db.execute("CREATE TABLE NextReading ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "bookId TEXT,"
          "title TEXT,"
          "authors TEXT,"
          "image TEXT,"
          "description TEXT,"
          "publishedDate TEXT,"
          "selfLink TEXT"
          ")");

      await db.execute("CREATE TABLE NowReading ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "bookId TEXT,"
          "title TEXT,"
          "authors TEXT,"
          "image TEXT,"
          "description TEXT,"
          "publishedDate TEXT,"
          "selfLink TEXT"
          ")");

      await db.execute("CREATE TABLE CompletedBooks ("
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

// #region [CREATE] METHODS
  Future<int> newItem(BookSQLite book, String table) async {
    final db = await database;
    var res = await db.insert(table, book.toMap());
    return res;
  }
// #endregion

// #region [GET] METHODS
  Future<BookSQLite> getOne(int id, String table) async {
    final db = await database;
    var res = await db.query(table, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? BookSQLite.fromMap(res.first) : Null;
  }

  Future<List<BookSQLite>> getAll(String table) async {
    final db = await database;
    var res = await db.query(table);
    List<BookSQLite> list =
        res.isNotEmpty ? res.map((c) => BookSQLite.fromMap(c)).toList() : [];
    return list;
  }
// #endregion

// #region [DELETE] METHODS
  Future<int> deleteAll(String table) async {
    final db = await database;
    return db.delete(table);
  }

  Future<int> deleteOne(int id, String table) async {
    final db = await database;
    return await db.delete(table, where: "id = ?", whereArgs: [id]);
  }
}
// #endregion
