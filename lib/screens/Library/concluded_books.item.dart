import 'package:flutter/material.dart';
import 'package:read_it_later/models/BookFromSQLite.dart';
import 'package:read_it_later/screens/Library/library.controller.dart';
import 'package:read_it_later/widgets/body.item.dart';
import 'package:read_it_later/widgets/text.item.dart';

import '../../Strings.dart';
import '../book_details.page.dart';
import 'library.item.dart';

class ConcludedBooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookSQLite>>(
      future: LibraryController.instance.completedItems,
      builder:
          (BuildContext context, AsyncSnapshot<List<BookSQLite>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return BodyItem(
                centerText: TextItem(data: Strings.emptyLibraryPageTwo));
          }

          return Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                BookSQLite item = snapshot.data[index];
                return LibraryItem(
                  id: item.id,
                  bookTitle: item.title,
                  bookAuthor: item.authors,
                  imageLink: item.image,
                  selfLink: item.selfLink,
                  bookDescription: item.description,
                  bookPublishedDate: item.publishedDate,
                  icon: Icon(Icons.check),
                  activeIcon: false,
                  seeDetails: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookDetailsPage(
                              freeNextReading: false,
                              freeConclutedBooks: true,
                              id: item.id,
                              title: item.title ?? '\"Título desconhecido\"',
                              authors: item.authors ?? '\"Autor desconhecido\"',
                              description:
                                  item.description ?? '\"Livro sem descrição\"',
                              image: item.image,
                              publishedDate:
                                  item.publishedDate ?? '\"Desconhecida\"',
                              selfLink: item.selfLink ??
                                  '\"Link próprio desconhecido\"',
                            )),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
