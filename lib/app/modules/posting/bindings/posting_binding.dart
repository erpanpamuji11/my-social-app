import 'package:get/get.dart';
import 'package:mysocial_app/app/modules/posting/controllers/comment_controller.dart';

import '../controllers/posting_controller.dart';

class PostingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentController>(
      () => CommentController(),
    );
    Get.lazyPut<PostingController>(
      () => PostingController(),
    );
  }
}
