import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlertDelayedDialog(BuildContext context, String title, String content) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(title: Text(title), content: Text(content));

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pop(true);
      });
      return alert;
    },
  );
}
