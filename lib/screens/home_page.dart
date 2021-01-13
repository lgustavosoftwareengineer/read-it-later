import 'package:flutter/material.dart';
import 'package:read_it_later/controllers/books_saved.controller.dart';
import 'package:read_it_later/models/Book.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';
import 'package:read_it_later/widgets/card.item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books;
  @override
  void initState() {
    setState(() {
      books = booksSavedController.showAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(text: 'Qual será a próxima leitura?'),
        body: AnimatedBuilder(
          animation: booksSavedController,
          builder: (context, child) {
            if (books.length < 1) {
              return Center(
                child: Text('Você ainda não tem nenhum livro marcado para ler depois'),
              );
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
                    return NRCard(
                        bookTitle: books[index].title,
                        bookAuthor: books[index].authors,
                        imageLink: books[index].image,
                        selfLink: books[index].selfLink,
                        icon: Icon(Icons.check),
                        action: () {
                          booksSavedController.removeOneItem(index);
                          setState(() {
                            books = booksSavedController.showAll();
                          });
                        });
                  },
                ));
          },
        ));
  }
}
