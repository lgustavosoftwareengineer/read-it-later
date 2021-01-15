import 'package:flutter/material.dart';
import 'package:read_it_later/Strings.dart';
import 'package:read_it_later/controllers/books_saved.controller.dart';
import 'package:read_it_later/handlers/snackbar.handler.dart';
import 'package:read_it_later/models/Book.dart';
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
        body: AnimatedBuilder(
          animation: BooksSavedController.instance,
          builder: (context, child) {
            if (books.length < 1) {
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
                  itemCount: books.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(index);
                    return Dismissible(
                      key: Key(index.toString()),
                      direction: DismissDirection.startToEnd,
                      background: DismissibleContainerItem(color: Colors.blueAccent,
                          icon: Icon(Icons.check), direction: Alignment.centerLeft),
                      onDismissed: (direction) {
                        BooksSavedController.instance.sendToTrash(index);
                        new SnackBarHandler().showSnackbar(
                            context: context,
                            message: 'Leitura do livro concluida com sucesso');
                      },
                      child: NRCard(
                        bookTitle: books[index].title,
                        bookAuthor: books[index].authors,
                        imageLink: books[index].image,
                        selfLink: books[index].selfLink,
                        icon: Icon(Icons.check),
                        activeIcon: false,
                      ),
                    );
                  },
                ));
          },
        ));
  }
}
