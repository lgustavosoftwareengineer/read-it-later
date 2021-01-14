import 'package:flutter/material.dart';
import 'package:read_it_later/constants.dart';
import 'package:read_it_later/controllers/books_saved.controller.dart';
import 'package:read_it_later/models/Book.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';
import 'package:read_it_later/widgets/card.item.dart';

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
              return Center(
                child: Text(Texts['empty_trash_page']),
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
                        icon: Icon(Icons.delete),
                        action: () {
                          BooksSavedController.instance.removePermanentily(index);
                        });
                  },
                ));
          },
        ));
  }
}
