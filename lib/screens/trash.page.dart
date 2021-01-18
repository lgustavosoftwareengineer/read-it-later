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

class TrashPage extends StatefulWidget {
  @override
  _TrashPageState createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  List<Book> books;

  @override
  void initState() {
    setState(() {
      books = BooksSavedController.instance.trash;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(text: 'Leituras concluídas'),
        body: FutureBuilder<List<BookSQLite>>(
          future: DBProvider.db.getAllBooksFromTrash(),
          builder:
              (BuildContext context, AsyncSnapshot<List<BookSQLite>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return BodyItem(centerText: TextItem(data: Strings.empty_trash_page));
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
                            DBProvider.db.removePermanentilyTheBook(item.id);
                            new SnackBarHandler().showSnackbar(
                                context: context,
                                message: 'Livro removido permanentemente');
                          } else {
                            DBProvider.db.newBook(item);
                            DBProvider.db.removePermanentilyTheBook(item.id);
                            new SnackBarHandler().showSnackbar(
                                context: context,
                                message:
                                    'Livro voltou para a sua lista de próximas leituras');
                          }
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
