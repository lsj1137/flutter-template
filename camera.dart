/*
Date: 2024.09.03
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe: 
This document is about camera function.
Dependency documents:
https://pub.dev/packages/camera
https://pub.dev/packages/flutter_spinkit
*/

import 'package:camera/camera.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


late List<CameraDescription> _cameras;
late CameraController? controller;
bool cameraInitialized = false;
bool isPictureCapturing = false;
double x = 0;
double y = 0;

@override
void initState() {
  prepareCam();
  super.initState();
}

@override
void dispose() {
  if (controller != null) {
    controller!.dispose();
  }
  super.dispose();
}

@override
Widget build(BuildContext context) {
  const spinKit = SpinKitFadingCircle(color: Colors.black);
  return Material(
    color: Colors.white,
    child: !cameraInitialized
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                spinKit,
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text("Loading Camera..."),
                  ),
                )
              ],
            ),
          )
        : Stack(
            children: [
              CameraView(),
            ],
          ),
  );
}

// let camera prepared
void prepareCam() async {
  _cameras = await availableCameras();
  CameraDescription backCam = _cameras[0];
  for (var cam in _cameras) // find camera backward
  {
    if (cam.lensDirection == CameraLensDirection.back) {
      backCam = cam;
      break;
    }
  }

  if (!cameraInitialized) {
    controller = CameraController(backCam, ResolutionPreset.veryHigh);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller!.setFlashMode(FlashMode.off);
      setState(() {
        cameraInitialized = true;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
  }
}


// camera screen
Widget CameraView () {
  // screenWidth
  double fullWidth = MediaQuery.of(context).size.width;
  // cameraHeight = screenWidth x cameraRatio
  double cameraHeight = fullWidth * controller!.value.aspectRatio;
  // scale = screenHeight / cameraHeight
  var scale = MediaQuery.of(context).size.height / cameraHeight;
  return Transform.scale(
    scale: scale,
    child: Center(
      child: CameraPreview(
        controller!,
        child: GestureDetector(onTapDown: (TapDownDetails details) {
          x = details.localPosition.dx;
          y = details.localPosition.dy;

          double xp = x / fullWidth;
          double yp = y / cameraHeight;

          Offset point = Offset(xp,yp);
          controller!.setFocusPoint(point);
        },),
      ),
    ),
  );
}


// take a photo
Future<void> takePhoto() async {
  if (controller!.value.isInitialized) {
    controller!.setFocusMode(FocusMode.locked);
    final XFile image = await controller!.takePicture();
    controller!.setFocusMode(FocusMode.auto);
    // TODO
  } else {
    print("Failed to take a photo.");
  }
}
