import 'package:flutter/material.dart';
import 'package:read_it_later/Strings.dart';
import 'package:read_it_later/handlers/bottom_drawer.handler.dart';
import 'package:read_it_later/handlers/search_delgates.handler.dart';
import 'package:read_it_later/handlers/snackbar.handler.dart';
import 'package:read_it_later/models/BookFromSQLite.dart';
import 'package:read_it_later/screens/Home/home.controller.dart';
import 'package:read_it_later/screens/Library/library.controller.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';
import 'package:read_it_later/widgets/body.item.dart';
import 'package:read_it_later/widgets/card.item.dart';
import 'package:read_it_later/widgets/dismissible_container.item.dart';
import 'package:read_it_later/widgets/text.item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  _handlerOnDismissed(BookSQLite item) async {
    await LibraryController.instance.addBookInCompletedBooks('NowReading', item.id);
    new SnackBarHandler().showSnackbar(
        context: context,
        message: 'Leitura do livro ${item.title} concluida com sucesso');
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = CustomAppBar(text: Strings.titleHomePage, hasSpace: true, actions: [
      IconButton(
        icon: Icon(Icons.menu,
            color: Theme.of(context).textTheme.bodyText1.color),
        onPressed: () => BottomDrawerHandler().showMenu(context),
      )
    ]);
    final _body = FutureBuilder<List<BookSQLite>>(
      future: HomeController.instance.nowReading,
      builder:
          (BuildContext context, AsyncSnapshot<List<BookSQLite>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return BodyItem(centerText: TextItem(data: Strings.emptyHomePage));
          }

          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //   Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15),
                  //   child: Text('O que estou lendo', style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold
                  //   ),),
                  // ),
                  Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        BookSQLite item = snapshot.data[index];
                        return Dismissible(
                          key: Key(index.toString()),
                          direction: DismissDirection.startToEnd,
                          background: DismissibleContainerItem(
                              color: Colors.greenAccent,
                              icon: Icon(Icons.check),
                              direction: Alignment.centerLeft),
                          onDismissed: (direction) {
                            _handlerOnDismissed(item);
                          },
                          child: NRCard(
                            id: item.id,
                            bookTitle: item.title,
                            bookAuthor: item.authors,
                            imageLink: item.image,
                            selfLink: item.selfLink,
                            icon: Icon(Icons.check),
                            bookDescription: item.description,
                            bookPublishedDate: item.publishedDate,
                            activeIcon: false,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ));
        } else if (snapshot.hasError) {
          return BodyItem(centerText: TextItem(data: Strings.error));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    final _floatingActionButton = FloatingActionButton.extended(
        onPressed: () => SearchDelgateHandler().handlerShowSearch(context),
        label: Text(
          Strings.homeTextFloatingActionButton,
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ));
    return Scaffold(
      appBar: _appBar,
      body: _body,
      floatingActionButton: _floatingActionButton,
    );
  }
}
