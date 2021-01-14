import 'package:flutter/material.dart';
import 'package:read_it_later/screens/wrapper.page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Read It Latter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColorBrightness: Brightness.light
      ),
      home: DefaultTabController(length: 3, child: Wrapper()),

      
      
    );
  }
}
