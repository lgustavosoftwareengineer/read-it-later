import 'package:flutter/material.dart';
import 'package:read_it_later/Strings.dart';
import 'package:read_it_later/controllers/books_saved.controller.dart';
import 'package:read_it_later/handlers/snackbar.handler.dart';
import 'package:read_it_later/models/BookFromHttpRequest.dart';
import 'package:read_it_later/models/BookFromSQLite.dart';
import 'package:read_it_later/services/DBProvider.dart';
import 'package:read_it_later/services/HttpRequests.dart';

class NRCard extends StatefulWidget {
  final String bookTitle;
  final String bookAuthor;
  final String imageLink;
  final String selfLink;
  final Icon icon;
  final bool activeIcon;

  const NRCard(
      {Key key,
      this.bookTitle,
      this.bookAuthor,
      this.imageLink,
      this.selfLink,
      this.icon,
      this.activeIcon})
      : super(key: key);
  @override
  _NRCardState createState() => _NRCardState();
}

class _NRCardState extends State<NRCard> {
  Future<BookFromHttpRequest> book;

  handlerNRListTile() {
    HttpRequests().fetchBook(link: widget.selfLink).then((value) =>
        DBProvider.db.newBook(new BookSQLite(
            title: value.title,
            authors: value.authors,
            bookId: value.id,
            description: value.description,
            image: value.image,
            publishedDate: value.publishedDate,
            selfLink: value.selfLink)));
    SnackBarHandler().showSnackbar(
      context: context,
      message:
          '${widget.bookTitle} foi adicionado a sua lista de próximas leituras',
    );
  }

  @override
  Widget build(BuildContext context) {
    // Validation if occur some error in return the Book widget
    final NRListTile = widget.bookTitle == '[error]'
        ? Container()
        : TextButton(
            onPressed: () => {print('hello')},
            onLongPress: () => print('opa'),
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Colors.white24))),
                  child: Image.network('${widget.imageLink}'),
                ),
                title: Text(
                  "${widget.bookTitle}",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      "${widget.bookAuthor}",
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ))
                  ],
                ),
                trailing: widget.activeIcon == true
                    ? IconButton(
                        icon: Icon(Icons.bookmark_sharp),
                        color: Colors.blueAccent,
                        iconSize: 30.0,
                        onPressed: handlerNRListTile)
                    : Container(width: 30, height: 30)));

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(),
        child: NRListTile,
      ),
    );
  }
}
