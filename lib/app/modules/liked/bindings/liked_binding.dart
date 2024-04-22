import 'package:get/get.dart';

import '../controllers/liked_controller.dart';

class LikedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LikedController>(
      () => LikedController(),
    );
  }
}
