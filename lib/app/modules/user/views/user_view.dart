import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mysocial_app/app/components/shimmer_user.dart';
import 'package:mysocial_app/app/core/style/style_color.dart';
import 'package:mysocial_app/app/core/style/style_text.dart';
import 'package:mysocial_app/app/modules/user/views/user_detail_view.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UserController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: CustomColor.background,
          appBar: AppBar(
            title: Text(
              'mySocial',
              style: h2Bold(),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              controller.refreshData();
            },
            child: Obx(
              () => controller.isLoading == true
                  ? shimmerUser()
                  : ListView.separated(
                      controller: controller.scrollController,
                      itemCount: controller.hasMore.value
                          ? controller.userList.length + 1
                          : controller.userList.length,
                      separatorBuilder: (context, index) => SizedBox(
                        width: Get.width,
                        height: 2,
                      ),
                      itemBuilder: (context, index) {
                        if (index < controller.userList.length) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => const UserDetailView(),
                                  arguments: controller.userList[index].id);
                            },
                            child: ListTile(
                              tileColor: CustomColor.primary100,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(controller
                                                .userList[index].picture ??
                                            ""))),
                              ),
                              title: Text(
                                "${controller.userList[index].title ?? ""}. ${controller.userList[index].firstName} ${controller.userList[index].lastName}",
                                style: b1Medium(),
                              ),
                            ),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: CustomColor.primary500,
                                color: CustomColor.primary700,
                              ),
                            ),
                          );
                        }
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
