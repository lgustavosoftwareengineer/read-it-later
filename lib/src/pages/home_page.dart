import 'package:flutter/material.dart';
import 'package:read_it_later/src/models/book.model.dart';
import 'package:read_it_later/src/services/api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Book> futureBook;

  @override
  void initState() {
    super.initState();
    futureBook = fetchBook();
    print(futureBook);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aqui está sua lista de próximas leituras:',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Página inicial')
          ],
        ),
      ),
    );
  }
}
