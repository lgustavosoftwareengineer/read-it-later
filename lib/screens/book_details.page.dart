import 'package:flutter/material.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';
import 'package:read_it_later/widgets/body.item.dart';
import 'package:read_it_later/widgets/text.item.dart';

import '../Strings.dart';

class BookDetailsPage extends StatefulWidget {
  final String id;
  final String title;
  final String authors;
  final String image;
  final String description;
  final String publishedDate;
  final String selfLink;

  const BookDetailsPage({Key key, this.id, this.title, this.authors, this.image, this.description, this.publishedDate, this.selfLink}) : super(key: key);
  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(leading: IconButton(icon: Icon(Icons.keyboard_arrow_left, color: Colors.blue,), onPressed: () { Navigator.pop(context);},),text: '${widget.title}'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
         child: SingleChildScrollView(
           child: Column(
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Image.network('${widget.image}', scale: 0.4,),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 5),
                 child: Text('Autor:', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
               ),
               Divider(),
               Text('${widget.authors}', style: TextStyle(fontSize: 20)),
               Divider(),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 5),
                 child: Text('Data de publicação:', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
               ),
               Divider(),
               Text('${widget.publishedDate}', style: TextStyle(fontSize: 20)),
               Divider(),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 5),
                 child: Text('Descrição', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
               ),
               Divider(),
               Padding(
                 padding: const EdgeInsets.only(bottom: 10),
                 child: Text('${widget.description}', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
               ),
             ],
           ),
         ),
      ),
    );
  }
}

