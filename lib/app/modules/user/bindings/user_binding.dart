import 'package:get/get.dart';

import 'package:mysocial_app/app/modules/user/controllers/user_detail_controller.dart';

import '../controllers/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDetailController>(
      () => UserDetailController(),
    );
    Get.lazyPut<UserController>(
      () => UserController(),
    );
  }
}
