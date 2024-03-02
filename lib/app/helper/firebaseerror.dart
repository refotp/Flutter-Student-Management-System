import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AuthErrorHandling {
  static SnackbarController emailAlreadyExist() {
    return Get.snackbar(
      '',
      '',
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(
        Iconsax.forbidden,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      titleText: const Text(
        'Error',
        style: TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      ),
      messageText: const Text(
        'Email ini sudah terdaftar',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
