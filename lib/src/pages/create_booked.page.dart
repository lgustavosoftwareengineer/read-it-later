import 'package:flutter/material.dart';
import 'package:read_it_later/src/models/book.model.dart';
import 'package:read_it_later/src/services/api.dart';
import 'package:read_it_later/src/widgets/card.item.dart';

class CreatedBookedPage extends StatefulWidget {
  @override
  _CreatedBookedPageState createState() => _CreatedBookedPageState();
}

class _CreatedBookedPageState extends State<CreatedBookedPage> {
  Future<Books> books;
  String searchValue;

  handleInput(String value) {
    setState(() {
      searchValue = value;
      print(searchValue);
    });
  }

  searchForABook() {
    setState(() {
      books = fetchBooks(searchTerm: searchValue);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
              hintText: 'Digite aqui o nome do livro...',
              hintStyle: TextStyle(color: Colors.blue)),
          onChanged: handleInput,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: Colors.blue),
              onPressed: () => {searchForABook()})
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: FutureBuilder<Books>(
          future: books,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return NRCard(
                    bookTitle: snapshot.data.items[index].title,
                    bookAuthor: snapshot.data.items[index].title,
                    imageLink: snapshot.data.items[index].image,
                  );
                },
              );
            } else if (snapshot.hasError) {
              print('${snapshot.error}');
              return Center(child: Text("${snapshot.error}"));
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
