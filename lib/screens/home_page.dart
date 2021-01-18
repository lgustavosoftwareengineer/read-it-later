import 'package:flutter/material.dart';
import 'package:read_it_later/Strings.dart';
import 'package:read_it_later/controllers/books_saved.controller.dart';
import 'package:read_it_later/handlers/snackbar.handler.dart';
import 'package:read_it_later/models/Book.dart';
import 'package:read_it_later/models/BookFromSQLite.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';
import 'package:read_it_later/widgets/body.item.dart';
import 'package:read_it_later/widgets/card.item.dart';
import 'package:read_it_later/widgets/dismissible_container.item.dart';
import 'package:read_it_later/widgets/text.item.dart';

import '../Database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books;

  @override
  void initState() {
    setState(() {
      books = BooksSavedController.instance.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(text: 'Aqui estão as suas próximas leituras'),
        body: FutureBuilder<List<BookSQLite>>(
          future: DBProvider.db.getAllBooks(),
          builder:
              (BuildContext context, AsyncSnapshot<List<BookSQLite>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return BodyItem(
                    centerText: TextItem(data: Strings.empty_home_page));
              }
              
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      BookSQLite item = snapshot.data[index];
                      return Dismissible(
                        key: Key(index.toString()),
                        direction: DismissDirection.startToEnd,
                        background: DismissibleContainerItem(
                            color: Colors.blueAccent,
                            icon: Icon(Icons.check),
                            direction: Alignment.centerLeft),
                        onDismissed: (direction) async {
                          await DBProvider.db.sendBookFromTrash(item.id);
                          new SnackBarHandler().showSnackbar(
                              context: context,
                              message:
                                  'Leitura do livro concluida com sucesso');
                        },
                        child: NRCard(
                          bookTitle: item.title,
                          bookAuthor: item.authors,
                          imageLink: item.image,
                          selfLink: item.selfLink,
                          icon: Icon(Icons.check),
                          activeIcon: false,
                        ),
                      );
                    },
                  ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
