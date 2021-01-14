import 'package:flutter/material.dart';

class SnackBarHandler {

  showSnackbar({BuildContext context, String message}) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(message),
        duration: Duration(seconds: 1),
        ));
  }  
}