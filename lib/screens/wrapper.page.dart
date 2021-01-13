import 'package:flutter/material.dart';

import 'create_booked.page.dart';
import 'home_page.dart';
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
            CreatedBookedPage(),
            TrashPage(),
          ],
        ),
      ),
      bottomNavigationBar: new TabBar(
        tabs: [
          Tab(
            icon: new Icon(Icons.home),
          ),
          Tab(
            icon: new Icon(Icons.add),
          ),
          Tab(
            icon: new Icon(Icons.delete),
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
