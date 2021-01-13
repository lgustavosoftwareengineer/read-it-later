import 'package:flutter/material.dart';
import 'package:read_it_later/widgets/app_bar.item.dart';


class TrashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'Algum livro que você jogou fora?',),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          color: Colors.white,
          child:
          Text('Seja-bem vindo à lixeira', style: TextStyle(fontSize: 24))),
    );
  }
}
