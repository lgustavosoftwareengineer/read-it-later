import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String text;
  final Widget leading;
  CustomAppBar({Key key, this.text, this.leading})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.leading,
      title: Text(
        '${widget.text}',
        style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      
      elevation: 0,
    );
  }
}
