import 'package:flutter/material.dart';
import 'package:read_it_later/Strings.dart';
import 'package:read_it_later/handlers/snackbar.handler.dart';
import 'package:read_it_later/models/BookFromHttpRequest.dart';
import 'package:read_it_later/models/BookFromSQLite.dart';
import 'package:read_it_later/repositories/books.repository.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';
import 'package:read_it_later/widgets/body.item.dart';
import 'package:read_it_later/widgets/card.item.dart';
import 'package:read_it_later/widgets/dismissible_container.item.dart';
import 'package:read_it_later/widgets/text.item.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  Future<List<BookSQLite>> books = BooksRepository.instance.trash;

  _handlerFloatButton(){
    BooksRepository.instance.removeAllFromTrash();
    setState(() {
      books = BooksRepository.instance.trash;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = CustomAppBar(text: Strings.titleLibraryPage);
    final _body = FutureBuilder<List<BookSQLite>>(
      future: books,
      builder:
          (BuildContext context, AsyncSnapshot<List<BookSQLite>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return BodyItem(centerText: TextItem(data: Strings.emptyLibraryPage));
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
                      color: Colors.blueAccent,
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
                        BooksRepository.instance.removePermanentily(item.id);
                        new SnackBarHandler().showSnackbar(
                            context: context,
                            message:
                                '${item.title} foi removido permanentemente');
                      } else {
                        var booksRepository = BooksRepository.instance;
                        booksRepository.add(
                            item: BookFromHttpRequest(
                                title: item.title,
                                image: item.image,
                                authors: item.authors,
                                description: item.description,
                                publishedDate: item.publishedDate,
                                selfLink: item.selfLink));
                        booksRepository.removePermanentily(item.id);
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
    );
    final _floatingActionButton = FloatingActionButton.extended(
          onPressed: _handlerFloatButton,
          label: Text('Deletar tudo'),
          icon: Icon(Icons.delete));
    
    return Scaffold(
      appBar: _appBar,
      body: _body,
      floatingActionButton: _floatingActionButton,
    );
  }
}
