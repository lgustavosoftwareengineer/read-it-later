import 'package:flutter/material.dart';

class HiddenContainerItem extends StatefulWidget {
  final Icon icon;
  final Color color;
  final Alignment direction;

  const HiddenContainerItem({
    Key key,
    this.icon,
    this.color, this.direction,
  }) : super(key: key);

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
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: widget.direction == Alignment.centerLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          Align(
            alignment: widget.direction,
            child: IconButton(
              icon: widget.icon,
              color: Colors.white,
              onPressed: () => {},
            ),
          ),
          
        ],
      ),
    );
  }
}
