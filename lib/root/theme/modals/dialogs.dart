import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialog {
  loading() {
    Get.dialog(
        const PopScope(
          canPop: false,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        barrierDismissible: false);
  }
}