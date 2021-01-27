import 'dart:async';

import 'package:flutter/material.dart';
import 'package:read_it_later/handlers/search_delgates.handler.dart';
import 'package:read_it_later/models/BookFromHttpRequest.dart';
import 'package:read_it_later/services/HttpRequests.dart';
import 'package:read_it_later/widgets/card.item.dart';

class SearchBookPage extends StatefulWidget {
  final String searchTerm;
  const SearchBookPage({Key key, this.searchTerm}) : super(key: key);
  @override
  _SearchBookPageState createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
  Future<BooksFromHttpRequest> books;
  bool isSearching = false;

  void initState() {
    setState(() {
      books = HttpRequests().fetchBooks(searchTerm: widget.searchTerm);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      titleSpacing: 0,
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Theme.of(context).accentColor))
          : Icon(Icons.search, color: Theme.of(context).accentColor),
      title: Container(
        height: MediaQuery.of(context).size.height / 20,
        width: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
            style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
            cursorColor: Theme.of(context).textTheme.bodyText1.color,
            decoration: InputDecoration(
              hintText: '${widget.searchTerm}',
              hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
              border: InputBorder.none,
            ),
            readOnly: true,
            onTap: () => SearchDelgateHandler().handlerShowSearch(context),
          ),
      ),

      backgroundColor: Theme.of(context).canvasColor
      //elevation: 0,
    );
    final _body = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).canvasColor,
      child: FutureBuilder<BooksFromHttpRequest>(
        future: books,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.items.length,
              itemBuilder: (BuildContext context, int index) {
                return NRCard(
                  bookTitle: snapshot.data.items[index].title,
                  bookAuthor: snapshot.data.items[index].authors,
                  imageLink: snapshot.data.items[index].image,
                  selfLink: snapshot.data.items[index].selfLink,
                  bookDescription: snapshot.data.items[index].description,
                  bookPublishedDate: snapshot.data.items[index].publishedDate,
                  icon: Icon(Icons.add),
                  activeIcon: true,
                );
              },
            );
          } else if (snapshot.hasError || isSearching == false) {
            return Center(child: CircularProgressIndicator());
          }
          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );

    return Scaffold(appBar: _appBar, body: _body);
  }
}
