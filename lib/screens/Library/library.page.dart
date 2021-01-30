import 'package:flutter/material.dart';
import 'package:read_it_later/Strings.dart';
import 'package:read_it_later/screens/Library/library.controller.dart';
import 'package:read_it_later/screens/wrapper.page.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';

import 'concluded_books.item.dart';
import 'next_reading.item.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  _handlerFloatButton() {
    LibraryController.instance.removeAllBooksInCompletedBooks();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper()));
  }

  @override
  Widget build(BuildContext context) {
    final _appBar =
        CustomAppBar(text: Strings.titleLibraryPage, hasSpace: true);
    final _body = Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'O que ler depois?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            NextReadingPage(),
            Padding(padding: const EdgeInsets.symmetric(vertical: 20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Leituras concluidas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ConcludedBooksPage()
          ],
        ));

    final _floatingActionButton = FloatingActionButton.extended(
        onPressed: _handlerFloatButton,
        label: Text('Deletar tudo', style: TextStyle(color: Colors.white)),
        icon: Icon(Icons.delete, color: Colors.white));

    return Scaffold(
      appBar: _appBar,
      body: _body,
      floatingActionButton: _floatingActionButton,
    );
  }
}
