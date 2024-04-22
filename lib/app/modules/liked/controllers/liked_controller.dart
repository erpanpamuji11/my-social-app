import 'package:get/get.dart';
import 'package:mysocial_app/app/core/utils/hive_utils.dart';
import 'package:mysocial_app/app/core/utils/toast_utils.dart';
import 'package:mysocial_app/app/modules/user/models/post_user_model/post_item.dart';

class LikedController extends GetxController {
  var postList = <PostItem>[].obs;

  Future getPostList() async {
    postList.value = await PostService().getAllPost();
    update();
  }

  deletePost(int index) async {
    try {
      PostService().deletePost(index);
      update();
      getPostList();
    } catch (e) {
      ToastUtil.showNeutralMessage("failed delete");
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getPostList();
  }

  @override
  void onReady() {
    super.onReady();
    getPostList();
  }


  void increment() => count.value++;
}
