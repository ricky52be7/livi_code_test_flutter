import 'package:flutter/material.dart';

class CommonUtils {
  static showAlertDialog(
      {required BuildContext context,
      String? title = '',
      String message = '',
      Function? callback}) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$title"),
          content: Text("$message"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                if (callback != null) {
                  callback();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
