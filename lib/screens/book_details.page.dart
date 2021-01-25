import 'package:flutter/material.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';
import 'package:html/parser.dart';

import '../Strings.dart';

class BookDetailsPage extends StatefulWidget {
  final String id;
  final String title;
  final String authors;
  final String image;
  final String description;
  final String publishedDate;
  final String selfLink;

  const BookDetailsPage(
      {Key key,
      this.id,
      this.title,
      this.authors,
      this.image,
      this.description,
      this.publishedDate,
      this.selfLink})
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
    return Scaffold(
      appBar: CustomAppBar(
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          text: '${widget.title}'),
      body: Container(
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
                                  fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                            ),
                          ),
                          Divider(),
                          Text(widget.authors, style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Data de publicação',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                            ),
                          ),
                          Divider(),
                          Text(widget.publishedDate,
                              style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('Descrição',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)),
                  ),
                  Divider(),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Text(
                      _parseHtmlString(widget.description),
                      style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],

                ),
            ],
          ),
        ),
      ),
    );
  }
}
