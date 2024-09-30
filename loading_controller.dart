/*
Date: 2024.09.30
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe:
This document is about loading controller using GetX controller.
You can use this when doing async jobs.
Dependency documents:
https://pub.dev/packages/get
*/

import 'package:get/get.dart';

class LoadingController extends GetxController{
  LoadingController();

  RxBool isLoading = false.obs;

  void toggle () {
    isLoading.value = !isLoading.value;
  }

}