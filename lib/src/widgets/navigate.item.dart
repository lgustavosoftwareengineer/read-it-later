import 'package:flutter/material.dart';

class NavigateItem extends StatelessWidget {
  const NavigateItem(
      {Key key, this.route, this.icon, this.title, this.isMyRoute = false})
      : super(key: key);
  final String route;
  final IconData icon;
  final String title;
  final bool isMyRoute;

  @override
  Widget build(BuildContext context) {
    if (isMyRoute == false) 
      return FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(icon),
              ),
              Text(title)
            ],
          ));
     else return Container();
    
  }
}
