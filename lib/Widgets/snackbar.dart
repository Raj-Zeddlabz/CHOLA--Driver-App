import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor:
          const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
      colorText: Color(0xFF4320DB),
      duration:Duration(seconds: 5),
      snackPosition: SnackPosition.TOP,
    );
  }

  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red.withOpacity(0.7),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }
}
