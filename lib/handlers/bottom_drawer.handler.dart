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
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                            color: Theme.of(context).canvasColor),
                        child: Stack(
                          alignment: Alignment(0, 0),
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                              top: -36,
                              child: Container(
                                // decoration: BoxDecoration(
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(50)),
                                //     border: Border.all(
                                //         color: Theme.of(context).canvasColor,
                                //         width: 10)),
                                padding: EdgeInsets.all(8),
                                child: Center(
                                  child: Text('Configurações'),
                                ),
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
                                    leading:
                                        Icon(Icons.lightbulb_outline),
                                    onTap: () {
                                      ThemeController.instance.changeTheme();
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))),
                Container(
                  height: 56,
                  color: Theme.of(context).cardColor,
                )
              ],
            ),
          );
        });
  }
}
