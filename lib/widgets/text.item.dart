import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  final String data;
  final Color color;

  const TextItem({Key key, this.data, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          color: Theme.of(context).accentTextTheme.bodyText1.color,
          fontSize: MediaQuery.of(context).size.width / 25),
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
    );
  }
}
