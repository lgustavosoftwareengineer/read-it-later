import 'package:flutter/material.dart';
import 'package:read_it_later/Strings.dart';
import 'package:read_it_later/controllers/books.controller.dart';
import 'package:read_it_later/handlers/snackbar.handler.dart';
import 'package:read_it_later/models/BookFromHttpRequest.dart';
import 'package:read_it_later/models/BookFromSQLite.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';
import 'package:read_it_later/widgets/body.item.dart';
import 'package:read_it_later/widgets/card.item.dart';
import 'package:read_it_later/widgets/dismissible_container.item.dart';
import 'package:read_it_later/widgets/text.item.dart';

class TrashPage extends StatefulWidget {
  @override
  _TrashPageState createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  Future<List<BookSQLite>> books;

  @override
  void initState() {
    setState(() {
      books = BooksController.instance.trash;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(text: 'Leituras concluídas'),
        body: FutureBuilder<List<BookSQLite>>(
          future: books,
          builder:
              (BuildContext context, AsyncSnapshot<List<BookSQLite>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return BodyItem(
                    centerText: TextItem(data: Strings.emptyTrashPage));
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
                        background: DismissibleContainerItem(
                          color: Colors.greenAccent,
                          icon: Icon(Icons.refresh),
                          direction: Alignment.centerLeft,
                        ),
                        secondaryBackground: DismissibleContainerItem(
                          color: Colors.redAccent,
                          icon: Icon(Icons.delete),
                          direction: Alignment.centerRight,
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            BooksController.instance
                                .removePermanentily(item.id);
                            new SnackBarHandler().showSnackbar(
                                context: context,
                                message:
                                    '${item.title} foi removido permanentemente');
                          } else {
                            var bookControler = BooksController.instance;
                            bookControler.add(
                                item: BookFromHttpRequest(
                                    title: item.title,
                                    image: item.image,
                                    authors: item.authors,
                                    description: item.description,
                                    publishedDate: item.publishedDate,
                                    selfLink: item.selfLink));
                            bookControler.removePermanentily(item.id);
                            new SnackBarHandler().showSnackbar(
                                context: context,
                                message:
                                    '${item.title} voltou para a sua lista de próximas leituras');
                          }
                        },
                        child: NRCard(
                          bookTitle: item.title,
                          bookAuthor: item.authors,
                          imageLink: item.image,
                          selfLink: item.selfLink,
                          bookDescription: item.description,
                          bookPublishedDate: item.publishedDate,
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
