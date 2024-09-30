/*
Date: 2024.09.10
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe: 
This document is about loading screen with SpinKit.
Dependency documents:
https://pub.dev/packages/flutter_spinkit
*/

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingScreen(context) {
  return Container(
    color: Colors.white.withOpacity(0.8),
    child: Center(
      child: IntrinsicHeight(
        child: Column(
          children: [
            SpinKitThreeBounce(
              color: Colors.black,
              size: 40,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Loading..",
            )
          ],
        ),
      ),
    ),
  );
}
