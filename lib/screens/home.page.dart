import 'package:flutter/material.dart';
import 'package:read_it_later/Strings.dart';
import 'package:read_it_later/controllers/books.controller.dart';
import 'package:read_it_later/handlers/snackbar.handler.dart';
import 'package:read_it_later/models/BookFromSQLite.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';
import 'package:read_it_later/widgets/body.item.dart';
import 'package:read_it_later/widgets/card.item.dart';
import 'package:read_it_later/widgets/dismissible_container.item.dart';
import 'package:read_it_later/widgets/text.item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<BookSQLite>> books;

  @override
  void initState() {
    setState(() {
      books = BooksController.instance.items;
    });
  }

  handlerOnDismissed(BookSQLite item) async {
    await BooksController.instance.sendToTrash(item.id);
    new SnackBarHandler().showSnackbar(
        context: context,
        message: 'Leitura do livro ${item.title} concluida com sucesso');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(text: 'Aqui estão as suas próximas leituras'),
        body: FutureBuilder<List<BookSQLite>>(
          future: books,
          builder:
              (BuildContext context, AsyncSnapshot<List<BookSQLite>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return BodyItem(
                    centerText: TextItem(data: Strings.emptyHomePage));
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
                        onDismissed: (direction) {
                          handlerOnDismissed(item);
                        },
                        child: NRCard(
                          bookTitle: item.title,
                          bookAuthor: item.authors,
                          imageLink: item.image,
                          selfLink: item.selfLink,
                          icon: Icon(Icons.check),
                          bookDescription: item.description,
                          bookPublishedDate: item.publishedDate,
                          activeIcon: false,
                        ),
                      );
                    },
                  ));
            } else if (snapshot.hasError) {
              return BodyItem(centerText: TextItem(data: Strings.error));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
