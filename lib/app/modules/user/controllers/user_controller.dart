import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysocial_app/app/core/utils/debouncer_utils.dart';
import 'package:mysocial_app/app/core/utils/service_api_utils.dart';
import 'package:mysocial_app/app/modules/user/models/user_model.dart';

class UserController extends GetxController {
  int currentPage = 1;
  int currentLimit = 20;
  var hasMore = true.obs;
  var isReload = false.obs;
  RxBool isLoading = true.obs;

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  GlobalKey buttonKey = GlobalKey();

  var userList = <UserModel>[].obs;

  getUserList() async {
    await ApiServices.getData("user?limit=$currentLimit&page=$currentPage")
        .then((value) {
      try {
        isLoading.value = false;
        var data = value['data'] as List;
        List<UserModel> response =
            data.map((e) => UserModel.fromMap(e)).toList();
        if (response.length < currentLimit) {
          hasMore.value = false;
        }

        userList.addAll(response);
        currentPage++;
        isLoading.value = false;
        update();
      } catch (e) {
        debugPrint("error get data : $e");
        isLoading.value = false;
      }
    });
  }

  final DebouncerUtils debouncerUtils =
      DebouncerUtils(duration: const Duration(milliseconds: 1000));

  searchQuery(String query) async {
    debouncerUtils.run(() async {
      userList.value = [];
      currentPage = 1;
      isLoading.value = true;
      hasMore.value = true;
      update();
      await getUserList();
    });
  }

  Future<void> refreshData() async {
    currentPage = 1;
    update();
    isLoading.value = true;
    hasMore.value = true;
    userList.value = [];
    await Future.delayed(const Duration(seconds: 3));
    getUserList();
  }

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (maxScroll == currentScroll && hasMore.value) {
      getUserList();
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getUserList();
    scrollController.addListener(onScroll);
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
}
