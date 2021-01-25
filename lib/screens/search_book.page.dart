import 'dart:async';

import 'package:flutter/material.dart';
import 'package:read_it_later/Strings.dart';
import 'package:read_it_later/models/BookFromHttpRequest.dart';
import 'package:read_it_later/services/HttpRequests.dart';
import 'package:read_it_later/widgets/body.item.dart';
import 'package:read_it_later/widgets/card.item.dart';
import 'package:read_it_later/widgets/text.item.dart';

class SearchBookPage extends StatefulWidget {
  @override
  _SearchBookPageState createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
  Future<BooksFromHttpRequest> books;
  bool isSearching = false;

  searchOnChangeHandler(value) {
    Timer searchOnStoppedTyping;

    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() {
        isSearching = false;
        searchOnStoppedTyping.cancel();
      }); // clear timer
    }
    setState(() => searchOnStoppedTyping = new Timer(duration, () {
          isSearching = true;
          setState(() {
            books = HttpRequests().fetchBooks(searchTerm: value);
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Colors.white))
          : Icon(Icons.search, color: Colors.white),
      title: TextField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: 'Digite aqui o nome do livro...',
          hintStyle: TextStyle(color: Colors.white),
          
          border: InputBorder.none,
        ),
        onChanged: searchOnChangeHandler,
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
            return BodyItem(
                centerText: TextItem(data: Strings.emptySearchBookPage));
          }
          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );

    return Scaffold(appBar: _appBar, body: _body);
  }
}
