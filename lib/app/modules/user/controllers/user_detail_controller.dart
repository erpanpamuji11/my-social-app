import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysocial_app/app/core/utils/hive_utils.dart';
import 'package:mysocial_app/app/core/utils/service_api_utils.dart';
import 'package:mysocial_app/app/core/utils/toast_utils.dart';
import 'package:mysocial_app/app/modules/user/models/detail_user_model/detail_user_model.dart';
import 'package:mysocial_app/app/modules/user/models/post_user_model/post_item.dart';
import 'package:mysocial_app/app/modules/user/models/post_user_model/post_user_model.dart';

class UserDetailController extends GetxController {
  DetailUserModel detailUser = DetailUserModel();
  RxBool isLoading = true.obs;

  String userId = Get.arguments;

  int currentPage = 1;
  int currentLimit = 20;
  var hasMore = true.obs;
  var isReload = false.obs;
  RxBool isLoadingPost = true.obs;

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  GlobalKey buttonKey = GlobalKey();

  var postList = <PostUserModel>[].obs;

  getDetailUser() async {
    await ApiServices.getData('user/$userId').then((value) {
      try {
        detailUser = DetailUserModel.fromMap(value);
        update();
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
      }
    });
  }

  getPostList() async {
    await ApiServices.getData("user/$userId/post?page=1&limit=6").then((value) {
      try {
        var data = value['data'] as List;
        List<PostUserModel> response =
            data.map((e) => PostUserModel.fromMap(e)).toList();
        if (response.length < currentLimit) {
          hasMore.value = false;
        }
        postList.addAll(response);
        currentPage++;
        isLoadingPost.value = false;
        update();
      } catch (e) {
        debugPrint("error get data : $e");
        isLoadingPost.value = false;
      }
    });
  }

  Future<void> refreshData() async {
    currentPage = 1;
    update();
    isLoading.value = true;
    hasMore.value = true;
    postList.value = [];
    await Future.delayed(const Duration(seconds: 3));
    getPostList();
  }

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (maxScroll == currentScroll && hasMore.value) {
      getPostList();
    }
  }

  likePost(PostUserModel item, int index) async {
    try {
      final data = PostItem(
        item.id ?? "0",
        item.image ?? "",
        item.likes ?? 1,
        item.tags ?? [],
        item.text ?? "",
        item.publishDate ?? DateTime.now(),
        item.owner?.firstName ?? "",
        item.owner?.picture ?? "",
      );
      await PostService().addPost(data);
      ToastUtil.showNeutralMessage("Post Success");
      postList[index].liked = !postList[index].liked!;
      postList[index].likes = (item.likes! + 1);
      update();
    } catch (e) {
      ToastUtil.showNeutralMessage("Post failed $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(onScroll);
    getDetailUser();
    getPostList();
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
