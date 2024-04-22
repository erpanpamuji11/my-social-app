import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysocial_app/app/core/style/style_color.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
        messageText: const Text(
          'Please connect to the internet',
          style: TextStyle(color: Colors.white),
        ),
        isDismissible: false,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(days: 1),
        animationDuration: const Duration(milliseconds: 400),
        backgroundColor: CustomColor.netral700,
        icon: const Icon(
          Icons.wifi_off,
          color: Colors.white,
          size: 24,
        ),
        borderRadius: 16,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        snackStyle: SnackStyle.FLOATING,
        mainButton: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "Ok",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}