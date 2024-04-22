import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mysocial_app/app/core/utils/hive_utils.dart';
import 'package:mysocial_app/app/core/utils/service_api_utils.dart';
import 'package:mysocial_app/app/core/utils/toast_utils.dart';
import 'package:mysocial_app/app/modules/posting/models/comment_model/comment_model.dart';
import 'package:mysocial_app/app/modules/posting/models/tags.dart';
import 'package:mysocial_app/app/modules/user/models/post_user_model/post_item.dart';
import 'package:mysocial_app/app/modules/user/models/post_user_model/post_user_model.dart';

class PostingController extends GetxController {
  int currentPage = 1;
  int currentLimit = 20;
  var hasMore = true.obs;
  var isReload = false.obs;
  RxBool isLoading = true.obs;

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  var postList = <PostUserModel>[].obs;
  var commentList = <CommentModel>[].obs;

  List<Tags> tagList = [
    Tags("animal", false),
    Tags("dog", false),
    Tags("nature", false),
  ];

  RxBool isExpandTag = false.obs;
  String selectedtag = "animal";

  changeExpandTag() {
    isExpandTag.value = !isExpandTag.value;
    if (isExpandTag.value == false){
      postList.value = [];
      getPostList();
    }
  }

  changeTags(bool isSelect, int index) {
    for (var i = 0; i < tagList.length; i++) {
      tagList[i].isSelected = false;
    }
    tagList[index].isSelected = true;
    selectedtag = tagList[index].name;
    update();
    postList.value = [];
    getPostByTag();
  }

  getPostList() async {
    await ApiServices.getData("post?page=$currentPage&limit=$currentLimit")
        .then((value) {
      try {
        var data = value['data'] as List;
        List<PostUserModel> response =
            data.map((e) => PostUserModel.fromMap(e)).toList();
        if (response.length < currentLimit) {
          hasMore.value = false;
        }
        postList.addAll(response);
        currentPage++;
        isLoading.value = false;
        update();
      } catch (e) {
        debugPrint("error get data : $e");
        isLoading.value = false;
      }
    });
  }

  getPostByTag() async {
    await ApiServices.getData(
            "tag/$selectedtag/post?page=$currentPage&limit=$currentLimit")
        .then((value) {
      try {
        var data = value['data'] as List;
        List<PostUserModel> response =
            data.map((e) => PostUserModel.fromMap(e)).toList();
        if (response.length < currentLimit) {
          hasMore.value = false;
        }
        postList.addAll(response);
        currentPage++;
        isLoading.value = false;
        update();
      } catch (e) {
        debugPrint("error get data : $e");
        isLoading.value = false;
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
      postList[index].liked = !postList[index].liked!;
      postList[index].likes = (item.likes! + 1);
      update();
    } catch (e) {
      ToastUtil.showNeutralMessage("Post failed $e");
    }
  }

  getCommentByPost(String postId) async {
  
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
    getPostList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  void increment() => count.value++;
}
