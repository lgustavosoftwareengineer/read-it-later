import 'package:flutter/material.dart';
import 'package:read_it_later/controllers/theme.controller.dart';

class BottomDrawerHandler {
  showMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              color: Theme.of(context).cardColor
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 36,
                ),
                SizedBox(
                    height: (56 * 6).toDouble(),
                    child: Container(
                        decoration: BoxDecoration(

                            color: Theme.of(context).canvasColor),
                        child: Stack(
                          alignment: Alignment(0, 0),
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Positioned(
                              top: -53,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                width: MediaQuery.of(context).size.width,
                                child: ListTile(
                                  title: Text('Configurações', style: TextStyle(fontWeight: FontWeight.bold)),
                                )
                                
                              ),
                            ),
                            Positioned(
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      ThemeController.instance.getIsDark() ==
                                              true
                                          ? 'Tema claro'
                                          : 'Tema escuro',
                                      style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                    onTap: () {
                                      ThemeController.instance.changeTheme();
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))),

              ],
            ),
          );
        });
  }
}
