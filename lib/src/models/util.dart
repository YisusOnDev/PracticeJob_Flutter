import 'package:flutter/material.dart';
import 'package:practicejob/constants.dart';

class Util {
  static Future<void> showMyDialog(context, title, text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(text)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Dismiss', style: TextStyle(color: cPrimaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void _showMyDialog(BuildContext context, String s, String t) {}
}
