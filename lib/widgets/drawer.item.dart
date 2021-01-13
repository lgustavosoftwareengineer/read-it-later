import 'package:flutter/material.dart';

import 'navigate.item.dart';

class MyDrawer extends StatelessWidget {
  final String actualPage;

  const MyDrawer({Key key, this.actualPage = 'home'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerElements = [
      NavigateItem(icon: Icons.home, route: '/', title: 'Página inicial'),
      NavigateItem(icon: Icons.delete, route: '/trash', title: 'Lixeira'),
      NavigateItem(icon: Icons.ac_unit, route: '/booked/all', title: 'Próximas leituras'),
      NavigateItem(icon: Icons.ac_unit, route: '/booked/all/completed', title: 'Leituras concluidas'),
      NavigateItem(icon: Icons.ac_unit, route: '/booked/edit', title: 'Editar próxima leitura'),
    ];


    if (actualPage == '/') {
      Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 60),
            child: Column(
              children: [
                NavigateItem(
                    icon: Icons.home,
                    route: '/',
                    title: 'Pagina inicial',
                    isMyRoute: true),
                NavigateItem(icon: Icons.delete, route: '/trash', title: 'Lixeira'),
                NavigateItem(icon: Icons.ac_unit, route: '/', title: 'Aba 2'),
                NavigateItem(icon: Icons.ac_unit, route: '/', title: 'Aba 2'),
                NavigateItem(icon: Icons.ac_unit, route: '/', title: 'Aba 2'),
              ],
            ),
          ),
        ),
      );
    } else if (actualPage == '/trash') {
      return Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 60),
            child: Column(
              children: [
                NavigateItem(
                    icon: Icons.home, route: '/', title: 'Pagina inicial'),
                NavigateItem(
                    icon: Icons.delete,
                    route: '/trash',
                    title: 'Lixeira',
                    isMyRoute: true),
                NavigateItem(icon: Icons.ac_unit, route: '/', title: 'Aba 2'),
                NavigateItem(icon: Icons.ac_unit, route: '/', title: 'Aba 2'),
                NavigateItem(icon: Icons.ac_unit, route: '/', title: 'Aba 2'),
              ],
            ),
          ),
        ),
      );
    }

    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 60),
          child: Column(
            children: [
              NavigateItem(
                icon: Icons.home,
                route: '/',
                title: 'Pagina inicial',
                isMyRoute: true,
              ),
              NavigateItem(
                  icon: Icons.delete, route: '/trash', title: 'Lixeira'),
              NavigateItem(icon: Icons.ac_unit, route: '/', title: 'Aba 2'),
              NavigateItem(icon: Icons.ac_unit, route: '/', title: 'Aba 2'),
              NavigateItem(icon: Icons.ac_unit, route: '/', title: 'Aba 2'),
            ],
          ),
        ),
      ),
    );
  }
}
