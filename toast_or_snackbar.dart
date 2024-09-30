/*
Date: 2024.09.03
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe: 
This document is about toast/snackbar notification.
Dependency documents:
https://pub.dev/packages/fluttertoast
*/

import 'package:fluttertoast/fluttertoast.dart';

// Toast
Future<bool?> shortToast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      webBgColor: "black",
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0);
}

// SnackBar
void shortSnackbar(context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    ),
  );
}
