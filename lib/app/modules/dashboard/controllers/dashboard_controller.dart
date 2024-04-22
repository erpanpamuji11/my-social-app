import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mysocial_app/app/core/utils/toast_utils.dart';
import 'package:mysocial_app/app/modules/liked/views/liked_view.dart';
import 'package:mysocial_app/app/modules/posting/views/posting_view.dart';
import 'package:mysocial_app/app/modules/user/views/user_view.dart';
// ignore: depend_on_referenced_packages

class DashboardController extends GetxController {
  DateTime timebackPressed = DateTime.now();
  int selectedIndex = 0;
  Widget currentScreen = const UserView();

  final PageStorageBucket bucket = PageStorageBucket();

  Future<bool> doubleTapToBack() async {
    final difference = DateTime.now().difference(timebackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);

    timebackPressed = DateTime.now();

    if (isExitWarning) {
      ToastUtil.showNeutralMessage("Press back again to exit");
      return false;
    } else {
      Fluttertoast.cancel();
      return true;
    }
  }

  List<Widget> screens = [
    const UserView(),
    const PostingView(),
    const LikedView(),
  ];

  changeMenu(index) {
    switch (index) {
      case 0:
        currentScreen = screens[0];
        selectedIndex = 0;
        break;
      case 1:
        currentScreen = screens[1];
        selectedIndex = 1;
        break;
      case 2:
        currentScreen = screens[2];
        selectedIndex = 2;
        break;
    }
    update();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
