/*
Date: 2024.09.10
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe: 
This document is about drop-down menu with OverlayEntry.
Dependency documents:
None
*/

import 'package:flutter/material.dart';

// CompositedTransformFollower
// A follower is created at the target's position
OverlayEntry customDropdown(LayerLink layerLink, double width, widget) {
  return OverlayEntry(
    canSizeOverlay: true,
    builder: (context) => Positioned(
        width: width,
        height: 160, // TODO: customize menu's height
        child: CompositedTransformFollower(
          offset: Offset(-(width / 2) + 10, -14),
          link: layerLink,
          child: widget,
        )),
  );
}

// CompositedTransformTarget
class LayerLinkExample extends StatefulWidget {
  const LayerLinkExample({super.key});

  @override
  State<LayerLinkExample> createState() => _LayerLinkExampleState();
}

class _LayerLinkExampleState extends State<LayerLinkExample> {
  LayerLink layerLink =
      LayerLink(); // You MUST link two CompositedTransform widgets with this link.
  OverlayEntry? _overlayEntry;

  List<String> options = []; // Options that you want to show in dropdown menu
  String selectedOption = "";

  // Menu widget passed as a parameter to the method "_createOverlay"
  Widget optionWidget() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: options.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selectedOption = options[index];
                  });
                  _removeOverlay();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Center(child: Text(options[index])),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey.withOpacity(0.2),
              )
            ],
          );
        },
      ),
    );
  }

  void _createOverlay(LayerLink layerLink, double width, Widget widget) {
    if (_overlayEntry == null) {
      _overlayEntry = customDropdown(layerLink, width, widget);
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // DO NOT USE THIS METHOD AS IT IS. (Error occurs)
  // You might use LayoutBuilder widget which the method returns.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: () {
          // On/Off the Menu
          if (_overlayEntry == null) {
            _createOverlay(layerLink, constraints.maxWidth, optionWidget());
          } else if (!_overlayEntry!.mounted) {
            _createOverlay(layerLink, constraints.maxWidth, optionWidget());
          } else {
            _removeOverlay();
          }
        },
        child: Container(
          height: 50,
          child: Center(
            child: CompositedTransformTarget(
                link: layerLink, child: Text(selectedOption)),
          ),
        ),
      );
    });
  }
}
