/*
Date: 2024.09.03
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe: 
This document is about showing dialog.
Dependency documents:
https://api.flutter.dev/flutter/material/Dialog-class.html
*/

import 'package:flutter/material.dart';

class Dialogs {
  Dialogs();

  void dialog(BuildContext context,
      {required Widget contentWidget,
      required String yes,
      required String no,
      required onYes,
      required onNo,
      Alignment alignment = Alignment.bottomCenter}) {
    showDialog(
        context: context,
        // 다이얼로그 바깥영역 터치 설정
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            alignment: alignment,
            contentPadding: EdgeInsets.all(15),
            content: Container(
              decoration: dialogContentDeco,
              width: 350,
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: onYes,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(), //TODO
                                child: Center(
                                    child: Text(
                                  yes,
                                  style: textStyle,
                                )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: onNo,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(), //TODO
                                child: Center(
                                    child: Text(
                                  no,
                                  style: textStyle,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    contentWidget,
                  ],
                ),
              ),
            ),
            actionsPadding: EdgeInsets.zero,
          );
        });
  }

  void dialogNoCancel(BuildContext context,
      {required Widget contentWidget, required String yes, required onYes}) {
    showDialog(
        context: context,
        // 다이얼로그 바깥영역 터치 설정
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            alignment: Alignment.center,
            contentPadding: EdgeInsets.all(15),
            content: Container(
              decoration: dialogContentDeco,
              width: 350,
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: onYes,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(), //TODO
                                child: Center(
                                    child: Text(
                                  yes,
                                  style: textStyle,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    contentWidget,
                  ],
                ),
              ),
            ),
            actionsPadding: EdgeInsets.zero,
          );
        });
  }

  void DialogNoBtn(BuildContext context, {required Widget contentWidget}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.all(15),
            content: Container(
              decoration: dialogContentDeco,
              width: 350,
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    contentWidget,
                  ],
                ),
              ),
            ),
            actionsPadding: EdgeInsets.zero,
          );
        });
  }

  void fullScreenDialog(BuildContext context, {required Widget contentWidget}) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog.fullscreen(
              backgroundColor: Colors.transparent,
              child: Stack(children: [
                Center(child: contentWidget),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                )
              ]),
            ));
  }

  // show FadeOutDialog
  void showAutoDismissDialog(BuildContext context, Widget widget) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FadeOutDialog(
          widgetParam: widget,
        );
      },
    );
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }

  // Dialog design
  BoxDecoration dialogContentDeco = BoxDecoration(
    boxShadow: null,
    borderRadius: BorderRadius.circular(5),
    color: Colors.white,
  );
}

// FadeOut Dialog
class FadeOutDialog extends StatefulWidget {
  const FadeOutDialog({super.key, required this.widgetParam});
  final Widget widgetParam;

  @override
  _FadeOutDialogState createState() => _FadeOutDialogState();
}

class _FadeOutDialogState extends State<FadeOutDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();

    // rewind animation after duration
    Future.delayed(Duration(seconds: 2), () {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: UnconstrainedBox(
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: widget.widgetParam,
              ),
            ),
          ),
        );
      },
    );
  }
}
