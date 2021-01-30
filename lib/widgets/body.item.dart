import 'package:flutter/material.dart';

class BodyItem extends StatelessWidget {
  final Widget centerText;

  const BodyItem({Key key, this.centerText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 10,
          vertical: MediaQuery.of(context).size.height / 10
        ),
        child: Center(child: centerText));
  }
}
