import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysocial_app/app/core/utils/service_api_utils.dart';
import 'package:mysocial_app/app/modules/posting/models/comment_model/comment_model.dart';

class CommentController extends GetxController {
  int currentPage = 1;
  int currentLimit = 20;
  var hasMore = true.obs;
  var isReload = false.obs;
  RxBool isLoading = true.obs;

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  var commentList = <CommentModel>[].obs;
  String postId = "";

  Future<void> refreshData() async {
    currentPage = 1;
    update();
    isLoading.value = true;
    hasMore.value = true;
    commentList.value = [];
    await Future.delayed(const Duration(seconds: 3));
    getCommentByPost();
  }

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (maxScroll == currentScroll && hasMore.value) {
      getCommentByPost();
    }
  }

  getCommentByPost() async {
    await ApiServices.getData(
            "post/$postId/comment?page=0&limit=10")
        .then((value) {
      try {
        var data = value['data'] as List;
        List<CommentModel> response =
            data.map((e) => CommentModel.fromMap(e)).toList();
        if (response.length < currentLimit) {
          hasMore.value = false;
        }
        commentList.addAll(response);
        currentPage++;
        isLoading.value = false;
        update();
      } catch (e) {
        debugPrint("error get data : $e");
        isLoading.value = false;
      }
    });
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(onScroll);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (postId != ""){
        getCommentByPost();
      }
    });
  }



  void increment() => count.value++;
}
