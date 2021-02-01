import 'package:flutter/material.dart';
import 'package:read_it_later/handlers/snackbar.handler.dart';
import 'package:read_it_later/models/BookFromHttpRequest.dart';
import 'package:read_it_later/screens/Home/home.controller.dart';
import 'package:read_it_later/screens/Library/library.controller.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';
import 'package:html/parser.dart';

class BookDetailsPage extends StatefulWidget {
  final int id;
  final String title;
  final String authors;
  final String image;
  final String description;
  final String publishedDate;
  final String selfLink;
  final bool freeNextReading;
  final bool freeConclutedBooks;

  const BookDetailsPage(
      {Key key,
      this.id,
      this.title,
      this.authors,
      this.image,
      this.description,
      this.publishedDate,
      this.selfLink,
      this.freeNextReading,
      this.freeConclutedBooks})
      : super(key: key);
  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = CustomAppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        text: '${widget.title}',
        hasSpace: false);
    final _body = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.network(
                      widget.image,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'Autor',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        Divider(),
                        Text(widget.authors,
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .color)),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'Data de publicação',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        Divider(),
                        Text(widget.publishedDate,
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .color)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.freeNextReading
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.chrome_reader_mode_outlined,
                              color: Theme.of(context).accentColor),
                          onPressed: () {
                            HomeController.instance.addBookInNowReading(
                              item: new BookFromHttpRequest(
                              image: widget.image,
                              authors: widget.authors,
                              description: widget.description,
                              publishedDate: widget.publishedDate,
                              selfLink: widget.selfLink,
                              title: widget.title,
                            ));

                            LibraryController.instance.deleteBookInNextReading(widget.id);

                            SnackBarHandler().showSnackbar(
                              context: context,
                              message:
                                  '${widget.title} foi adicionado a sua lista de leituras de agora',
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.check,
                              color: Theme.of(context).accentColor),
                          onPressed: () {
                            LibraryController.instance.addBookInCompletedBooks(
                                'NextReading', widget.id);
                            
                            LibraryController.instance.deleteBookInNextReading(widget.id);

                            SnackBarHandler().showSnackbar(
                              context: context,
                              message:
                                  '${widget.title} foi adicionando para leituras concluidas',
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).accentColor),
                          onPressed: () {
                            LibraryController.instance
                                .deleteBookInNextReading(widget.id);

                            SnackBarHandler().showSnackbar(
                              context: context,
                              message:
                                  '${widget.title} foi removido permanentemente',
                            );
                          },
                        )
                      ],
                    ),
                  )
                : Container(),
            widget.freeConclutedBooks
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.refresh,
                              color: Theme.of(context).accentColor),
                          onPressed: () {
                            HomeController.instance.addBookInNowReading(
                              item: new BookFromHttpRequest(
                              image: widget.image,
                              authors: widget.authors,
                              description: widget.description,
                              publishedDate: widget.publishedDate,
                              selfLink: widget.selfLink,
                              title: widget.title,
                            ));

                            LibraryController.instance
                                .deleteBookInCompletedBooks(widget.id);

                            SnackBarHandler().showSnackbar(
                              context: context,
                              message:
                                  '${widget.title} foi adicionado a sua lista de leituras de agora',
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).accentColor),
                          onPressed: () {
                            LibraryController.instance
                                .deleteBookInCompletedBooks(widget.id);

                            SnackBarHandler().showSnackbar(
                              context: context,
                              message:
                                  '${widget.title} foi removido permanentemente',
                            );
                          },
                        )
                      ],
                    ),
                  )
                : Container(),
            Column(
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text('Descrição',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor)),
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Text(
                    _parseHtmlString(widget.description),
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.bodyText1.color),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }
}
