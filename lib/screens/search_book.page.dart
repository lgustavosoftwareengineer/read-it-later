import 'dart:async';

import 'package:flutter/material.dart';
import 'package:read_it_later/Strings.dart';
import 'package:read_it_later/handlers/search_delgates.handler.dart';
import 'package:read_it_later/models/BookFromHttpRequest.dart';
import 'package:read_it_later/services/HttpRequests.dart';
import 'package:read_it_later/widgets/body.item.dart';
import 'package:read_it_later/widgets/card.item.dart';
import 'package:read_it_later/widgets/custom_search_delgates.item.dart';
import 'package:read_it_later/widgets/text.item.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Colors.white))
          : Icon(Icons.search, color: Colors.white),
      title: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        height: MediaQuery.of(context).size.height / 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1.9),
          child: TextField(
            style: TextStyle(color: Colors.blueGrey),
            cursorColor: Colors.blueGrey,
            decoration: InputDecoration(
              hintText: '${widget.searchTerm}',
              hintStyle: TextStyle(color: Colors.blueGrey),
              border: InputBorder.none,
            ),
            readOnly: true,
            onTap: () => SearchDelgateHandler().handlerShowSearch(context),
          ),
        ),
      ),

      backgroundColor: Theme.of(context).accentColor,
      //elevation: 0,
    );

    final _body = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
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
