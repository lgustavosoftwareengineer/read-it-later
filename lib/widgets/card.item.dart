import 'package:flutter/material.dart';
import 'package:read_it_later/constants.dart';
import 'package:read_it_later/controllers/books_saved.controller.dart';
import 'package:read_it_later/models/Book.dart';
import 'package:read_it_later/services/api.dart';

class NRCard extends StatefulWidget {
  final String bookTitle;
  final String bookAuthor;
  final String imageLink;
  final String selfLink;
  final Icon icon;
  final Function action;

  const NRCard({
    Key key,
    this.bookTitle,
    this.bookAuthor,
    this.imageLink,
    this.selfLink,
    this.icon,
    this.action
  }) : super(key: key);
  @override
  _NRCardState createState() => _NRCardState();
}

class _NRCardState extends State<NRCard> {
  Future<Book> book;

  handlerNRListTile() {
    print(widget.selfLink);
    fetchBook(link: widget.selfLink)
        .then((value) => booksSavedController.add(value));

    print(booksSavedController.showAll());
  }

  handlerSetInController() {}

  @override
  Widget build(BuildContext context) {
    final NRListTile = widget.imageLink == ImageLinkDefault
        ? Container()
        : FlatButton(
            onPressed: () => print('Infos about the item'),
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
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

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
                trailing: IconButton(
                    icon: widget.icon,
                    color: Colors.blueAccent,
                    iconSize: 30.0,
                    onPressed: widget.action == null ? handlerNRListTile : widget.action )));

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
