/*
Date: 2024.09.03
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe: 
This document is about pdf viewer/controller.
Dependency documents:
https://pub.dev/packages/pdfx
*/

import 'dart:io';

import 'package:pdfx/pdfx.dart';

final int initialPage = 1;
late PdfController pdfController;
final TextEditingController _pageEditingController = TextEditingController();

@override
void initState() {
  pdfController = PdfController(
      document: PdfDocument.openData(File(widget.pdfPath).readAsBytes()),
      initialPage: initialPage
  );
  super.initState();
}

@override
void dispose() {
  pdfController.dispose();
  super.dispose();
}


// pdf viewer & page control widget
PdfView(
  builders: PdfViewBuilders<DefaultBuilderOptions>(
    options: const DefaultBuilderOptions(),
    documentLoaderBuilder: (_) =>
    const Center(child: CircularProgressIndicator()),
    pageLoaderBuilder: (_) =>
    const Center(child: CircularProgressIndicator()),
  ),
  controller: pdfController,
),
PdfPageNumber(
  controller: pdfController,
  builder: (_, loadingState, page, pagesCount) {
    _pageEditingController.text = page.toString();
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: , //TODO width
            height: , //TODO height
            decoration: const BoxDecoration(
              border:BorderDirectional(bottom: BorderSide()),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: ), //TODO padding,
              child: TextField(
                controller: _pageEditingController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero
                ),
                textAlign: TextAlign.center,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  pdfController.jumpToPage(int.parse(value));
                },
              ),
            ),
          ),
        ),
        Text('/'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: //TODO width,
            height:  //TODO height,
            decoration: const BoxDecoration(
              border:BorderDirectional(bottom: BorderSide()),
            ),
            child: Center(child: Text(pagesCount.toString())),
          ),
        ),
      ],
    );
  },
)