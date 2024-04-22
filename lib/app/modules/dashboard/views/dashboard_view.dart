import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:mysocial_app/app/core/style/style_color.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          body: LazyLoadIndexedStack(
            index: controller.selectedIndex,
            preloadIndexes: const [3],
            children: controller.screens,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: controller.selectedIndex,
            elevation: 0,
            height: 80,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            onDestinationSelected: (index) {
              // Memperbarui index saat tab diketuk
              controller.changeMenu(index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  CupertinoIcons.person,
                  color: CustomColor.primary600,
                ),
                selectedIcon: Icon(
                  CupertinoIcons.person_solid,
                  color: CustomColor.primary800,
                ),
                label: "Pengguna",
              ),
              NavigationDestination(
                icon: Icon(
                  CupertinoIcons.square_list,
                  color: CustomColor.primary600,
                ),
                selectedIcon: Icon(
                  CupertinoIcons.square_list_fill,
                  color: CustomColor.primary800,
                ),
                label: "Postingan",
              ),
              NavigationDestination(
                icon: Icon(
                  CupertinoIcons.heart,
                  color: CustomColor.primary600,
                ),
                selectedIcon: Icon(
                  CupertinoIcons.heart_fill,
                  color: CustomColor.primary800,
                ),
                label: "Disukai",
              ),
            ],
          ),
        );
      },
    );
  }
}
