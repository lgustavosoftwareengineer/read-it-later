import 'dart:async';

import 'package:flutter/material.dart';
import 'package:read_it_later/models/Book.dart';
import 'package:read_it_later/services/api.dart';
import 'package:read_it_later/widgets/card.item.dart';

class CreatedBookedPage extends StatefulWidget {
  @override
  _CreatedBookedPageState createState() => _CreatedBookedPageState();
}

class _CreatedBookedPageState extends State<CreatedBookedPage> {
  Future<Books> books;
  bool isSearching = false;

  _onChangeHandler(value) {
    Timer searchOnStoppedTyping;

    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() {
        isSearching = false;
        searchOnStoppedTyping.cancel();
        print('nao estou buscando');
      }); // clear timer
    }
    setState(() => searchOnStoppedTyping = new Timer(duration, () {
          isSearching = true;
          searchForABook(value);
        }));
  }

  searchForABook(value) {
    setState(() {
      books = fetchBooks(searchTerm: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      leading: Icon(Icons.search, color: Colors.blue),
      title: TextField(
        decoration: InputDecoration(
          hintText: 'Digite aqui o nome do livro...',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        onChanged: _onChangeHandler,
      ),

      backgroundColor: Colors.white,
      //elevation: 0,
    );

    final _body = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: FutureBuilder<Books>(
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
                  icon: Icon(Icons.add),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Tente buscar um livro na barra logo em cima'));
          } else if (isSearching == false) {
            return Center(
                child: Text('Tente buscar um livro na barra logo em cima'));
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );

    return Scaffold(appBar: _appBar, body: _body);
  }
}
