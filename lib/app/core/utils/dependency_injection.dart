import 'package:get/get.dart';
import 'package:mysocial_app/app/modules/dashboard/controllers/network_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
