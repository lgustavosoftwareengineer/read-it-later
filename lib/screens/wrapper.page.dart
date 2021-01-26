import 'package:flutter/material.dart';
import 'package:read_it_later/screens/library.page.dart';

import 'home.page.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _controller = new TabController(length: 2, vsync: this);
    final _body = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: TabBarView(
        controller: _controller,
        children: [
          HomePage(),
          LibraryPage(),
        ],
      ),
    );
    final _bottomNavigationBar = TabBar(
      controller: _controller,
      tabs: [
        Tab(
          icon: new Icon(Icons.bookmark_outline, color: Colors.white),
        ),
        Tab(
          icon: new Icon(Icons.check, color: Colors.white),
        ),
      ],
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label,
      // indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.white,
    );

    return Scaffold(
        body: _body,
        bottomNavigationBar: _bottomNavigationBar,
        backgroundColor: Theme.of(context).accentColor
    );
  }
}
