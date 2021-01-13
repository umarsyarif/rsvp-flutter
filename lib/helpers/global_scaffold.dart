import 'package:flutter/material.dart';

class GlobalScaffold {
  static final GlobalScaffold instance = GlobalScaffold();

  final scaffkey = GlobalKey<ScaffoldState>();

  void showSnackBar(String text, {Color color = Colors.red}) {
    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: color,
    );
    scaffkey.currentState.showSnackBar(snackbar);
  }
  
}
