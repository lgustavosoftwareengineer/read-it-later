import 'package:flutter/material.dart';

class NRCard extends StatelessWidget {
  final String bookTitle;
  final String bookAuthor;
  final String imageLink;

  const NRCard({Key key, this.bookTitle, this.bookAuthor, this.imageLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NRListTile = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Image.network('$imageLink'),
        ),
        title: Text(
          "$bookTitle",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          
          children: <Widget>[
            Expanded(child: Text("$bookAuthor", style: TextStyle(color: Colors.black), overflow: TextOverflow.ellipsis,))
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.keyboard_arrow_right),
          color: Colors.black,
          iconSize: 30.0,
          onPressed: () => print('$bookTitle, $bookAuthor, $imageLink'),
        ));

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(),
        child: NRListTile,
      ),
    );
  }
}
