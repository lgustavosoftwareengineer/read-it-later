import 'package:flutter/material.dart';
import 'package:read_it_later/Strings.dart';
import 'package:read_it_later/controllers/theme.controller.dart';
import 'package:read_it_later/handlers/search_delgates.handler.dart';
import 'package:read_it_later/handlers/snackbar.handler.dart';
import 'package:read_it_later/models/BookFromSQLite.dart';
import 'package:read_it_later/repositories/books.repository.dart';
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
    await BooksRepository.instance.sendToTrash(item.id);
    new SnackBarHandler().showSnackbar(
        context: context,
        message: 'Leitura do livro ${item.title} concluida com sucesso');
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = CustomAppBar(
      text: Strings.titleHomePage,
    );
    final _body = FutureBuilder<List<BookSQLite>>(
      future: BooksRepository.instance.items,
      builder:
          (BuildContext context, AsyncSnapshot<List<BookSQLite>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return BodyItem(centerText: TextItem(data: Strings.emptyHomePage));
          }

          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
    final _drawer = Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 15),
        children: <Widget>[
          ListTile(
            leading: ThemeController.instance.getIsDark() == true ? Icon(Icons.brightness_2_outlined) : Icon(Icons.brightness_1_outlined),
            horizontalTitleGap: 0,
            title: ThemeController.instance.getIsDark() == true ? Text('Tema light') :Text('Tema dark'),
            onTap: () {
              ThemeController.instance.changeTheme();
            },
          ),

        ],
      ),
    );
    return Scaffold(
      appBar: _appBar,
      body: _body,
      floatingActionButton: _floatingActionButton,
      drawer: _drawer,
    );
  }
}
