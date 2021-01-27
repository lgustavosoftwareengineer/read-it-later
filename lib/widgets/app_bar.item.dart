import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String text;
  final Widget leading;
  final bool hasSpace;
  CustomAppBar({Key key, this.text, this.leading, this.hasSpace})
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
      automaticallyImplyLeading: false,
      title: Text(
        '${widget.text}',
        style: TextStyle(
            color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      titleSpacing: widget.hasSpace ? 15 : 0,
      elevation: 0,
    );
  }
}
