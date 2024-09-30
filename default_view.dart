/*
Date: 2024.09.03
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe:
This document is about default StatefulWidget.
Dependency documents:
https://api.flutter.dev/flutter/material/Material-class.html
*/

import 'package:flutter/material.dart';

class DefaultView extends StatefulWidget {
  const DefaultView({super.key});

  @override
  State<DefaultView> createState() => _DefaultViewState();
}

class _DefaultViewState extends State<DefaultView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SizedBox(
            height: screenHeight - 20,
            child: Stack(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
