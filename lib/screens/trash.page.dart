import 'package:flutter/material.dart';
import 'package:read_it_later/Strings.dart';
import 'package:read_it_later/controllers/books_saved.controller.dart';
import 'package:read_it_later/handlers/snackbar.handler.dart';
import 'package:read_it_later/models/Book.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';
import 'package:read_it_later/widgets/body.item.dart';
import 'package:read_it_later/widgets/card.item.dart';
import 'package:read_it_later/widgets/hidden_container.item.dart';
import 'package:read_it_later/widgets/text.item.dart';

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
        appBar: CustomAppBar(text: 'Aqui está a Lixeira'),
        body: AnimatedBuilder(
          animation: BooksSavedController.instance,
          builder: (context, child) {
            if (books.length < 1) {
              return BodyItem(
                  centerText: TextItem(data: Strings.empty_trash_page));
            }
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: books.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: Key(index.toString()),
                      background: HiddenContainerItem(
                          color: Colors.greenAccent,
                          context: context,
                          icon: Icon(Icons.refresh),
                          iconTwo: Icon(Icons.delete)),
                      secondaryBackground: HiddenContainerItem(
                          color: Colors.redAccent,
                          context: context,
                          icon: Icon(Icons.refresh),
                          iconTwo: Icon(Icons.delete)),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          BooksSavedController.instance
                              .removePermanentily(index);
                          new SnackBarHandler().showSnackbar(
                              context: context,
                              message: 'Livro removido permanentemente');
                        } else {
                          BooksSavedController.instance.add(books[index]);
                          BooksSavedController.instance
                              .removePermanentily(index);
                          new SnackBarHandler().showSnackbar(
                              context: context,
                              message:
                                  'Livro voltou para a sua lista de próximas leituras');
                        }
                      },
                      child: NRCard(
                        bookTitle: books[index].title,
                        bookAuthor: books[index].authors,
                        imageLink: books[index].image,
                        selfLink: books[index].selfLink,
                        icon: Icon(Icons.refresh_sharp),
                        activeIcon: false,
                      ),
                    );
                  },
                ));
          },
        ));
  }
}
