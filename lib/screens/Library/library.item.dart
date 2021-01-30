import 'package:flutter/material.dart';

class LibraryItem extends StatefulWidget {
  final int id;
  final String bookTitle;
  final String bookAuthor;
  final String imageLink;
  final String selfLink;
  final String bookDescription;
  final String bookPublishedDate;
  final Icon icon;
  final bool activeIcon;
  final Function seeDetails;

  const LibraryItem(
      {Key key,
      this.bookTitle,
      this.bookAuthor,
      this.imageLink,
      this.selfLink,
      this.icon,
      this.activeIcon,
      this.bookDescription,
      this.bookPublishedDate,
      this.id, this.seeDetails})
      : super(key: key);
  @override
  _LibraryItemState createState() => _LibraryItemState();
}

class _LibraryItemState extends State<LibraryItem> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.seeDetails,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Image.network('${widget.imageLink}'),
      ),
    );
  }
}
