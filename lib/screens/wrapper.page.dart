import 'package:flutter/material.dart';

import 'home.page.dart';
import 'search_book.page.dart';
import 'trash.page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: TabBarView(
          children: [
            HomePage(),
            SearchBookPage(),
            TrashPage(),
          ],
        ),
      ),
      bottomNavigationBar: new TabBar(
        tabs: [
          Tab(
            icon: new Icon(Icons.menu_book_sharp),
          ),
          Tab(
            icon: new Icon(Icons.search_sharp),
          ),
          Tab(
            icon: new Icon(Icons.check),
          ),
        ],
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white38,
        indicatorSize: TabBarIndicatorSize.label,
        // indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.white,
      ),
      backgroundColor: Colors.blue
      
    );
  }
}
