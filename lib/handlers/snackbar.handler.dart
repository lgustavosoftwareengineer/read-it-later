import 'package:flutter/material.dart';

class SnackBarHandler {

  showSnackbar({BuildContext context, String message}) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).accentColor,
        content:
            Text(message, style: TextStyle(color: Colors.white)),
        duration: Duration(seconds: 2
        ),
        ));
  }  
}