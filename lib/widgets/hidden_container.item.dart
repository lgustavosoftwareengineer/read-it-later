import 'package:flutter/material.dart';

class HiddenContainerItem extends StatefulWidget {
  final Function changeTheColor;
  final BuildContext context;
  final Icon icon;
  final Icon iconTwo;
  final Color color;

  const HiddenContainerItem(
      {Key key,
      this.context,
      this.icon,
      this.iconTwo,
      this.changeTheColor, this.color,
      })
      : super(key: key);

  @override
  _HiddenContainerItemState createState() => _HiddenContainerItemState();
}

class _HiddenContainerItemState extends State<HiddenContainerItem> {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: widget.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: widget.icon,
              color: Colors.white,
              onPressed: () => {},
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: widget.iconTwo,
              color: Colors.white,
              onPressed: () => {},
            ),
          )
        ],
      ),
    );
  }
}
