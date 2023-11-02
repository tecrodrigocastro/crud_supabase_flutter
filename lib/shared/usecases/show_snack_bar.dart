import 'package:flutter/material.dart';

void showMessageSnackBar(
  BuildContext context,
  String message, {
  Color? color,
}) {
  final snackbar = SnackBar(
    backgroundColor: color,
    content: Text(message),
    behavior: SnackBarBehavior.floating,
  );

  final scaffoldMsg = ScaffoldMessenger.of(context);
  scaffoldMsg
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);
}
