import 'package:flutter/material.dart';

import 'home.page.dart';
import 'search_book.page.dart';
import 'trash.page.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _controller = new TabController(length: 2, vsync: this);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: TabBarView(
          controller: _controller,
          children: [
            HomePage(),
            TrashPage(),
          ],
        ),
      ),
      bottomNavigationBar: new TabBar(
        controller: _controller,
        tabs: [
          Tab(
            icon: new Icon(Icons.menu_book_sharp),
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
