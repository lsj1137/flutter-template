/*
Date: 2024.09.03
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe: 
This document is about dio package, which is for http request/response.
Dependency documents:
https://pub.dev/packages/dio
*/

import 'dart:convert';

import 'package:dio/dio.dart' as dio;

final dioInstance = dio.Dio();

// Api method
Future<void> method(context, id, pw) async {
  const url = "http://";
  var enteredData = {
    "key": "value",
  };
  print(enteredData);
  var jsonData = jsonEncode(enteredData);
  try {
    var response = await dioInstance.post(url,
        data: jsonData); //GET, POST, PATCH, UPDATE, DELETE, ...
    if (response.statusCode == 200) {
      print(response.data);
      // TODO
    } else {
      print("Request Failed with ${response.statusCode}");
    }
  } on Exception catch (e) {
    print("Request Failed with Error");
    print(e);
  }
}

// set access token to dio header (if you use JWT Token)
dioInstance.options.headers['Authorization'] = 'Bearer ${accessToken}';