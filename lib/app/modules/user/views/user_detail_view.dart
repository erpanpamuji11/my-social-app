import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:mysocial_app/app/components/bottomsheet_comment.dart';
import 'package:mysocial_app/app/components/custom_post_item.dart';
import 'package:mysocial_app/app/components/shimmer_detail_user.dart';
import 'package:mysocial_app/app/components/shimmer_post.dart';
import 'package:mysocial_app/app/core/style/style_color.dart';
import 'package:mysocial_app/app/core/style/style_text.dart';
import 'package:mysocial_app/app/modules/user/controllers/user_detail_controller.dart';

class UserDetailView extends GetView<UserDetailController> {
  const UserDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UserDetailController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: CustomColor.primary100,
          appBar: AppBar(
            backgroundColor: CustomColor.primary100,
            title: Text(
              'Detail Pengguna',
              style: h4Bold(),
            ),
          ),
          body: SingleChildScrollView(
            controller: controller.scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: controller.isLoading == true
                        ? shimmerDetailUser()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        controller.detailUser.picture ?? ""),
                                  ),
                                ),
                              ),
                              const Gap(12),
                              Text(
                                "${controller.detailUser.title ?? ""}. ${controller.detailUser.firstName} ${controller.detailUser.lastName}",
                                style: b1Bold(),
                              ),
                              const Gap(8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    size: 20,
                                    color: CustomColor.primary700,
                                  ),
                                  const Gap(12),
                                  Text(
                                    controller.detailUser.phone ?? "",
                                    style: b2Medium(),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.home_filled,
                                    size: 20,
                                    color: CustomColor.primary700,
                                  ),
                                  const Gap(12),
                                  Expanded(
                                    child: Text(
                                      "${controller.detailUser.location?.street}, ${controller.detailUser.location?.city}, ${controller.detailUser.location?.state}, ${controller.detailUser.location?.country}",
                                      style: b2Medium(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.email,
                                    size: 20,
                                    color: CustomColor.primary700,
                                  ),
                                  const Gap(12),
                                  Text(
                                    controller.detailUser.email ?? "",
                                    style: b2Medium(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                  const Gap(30),
                  const Gap(12),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      "Postingan",
                      style: b1Bold(),
                    ),
                  ),
                  const Gap(12),
                  controller.isLoadingPost == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: shimmerPost())
                      : controller.postList.isEmpty
                          ? Padding(
                            padding: EdgeInsets.all(Get.width * 0.1),
                            child: Center(child: Text("Tidak ada Postingan", style: b2Reguler(),)),
                          )
                          : ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.hasMore.value
                                  ? controller.postList.length + 1
                                  : controller.postList.length,
                              separatorBuilder: (context, index) => Column(
                                children: [
                                  const Gap(12),
                                  Container(
                                    height: 2,
                                    width: Get.width,
                                    color: CustomColor.netral300,
                                  ),
                                  const Gap(12),
                                ],
                              ),
                              itemBuilder: (context, index) {
                                if (index < controller.postList.length) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: CustomPostItem(
                                      data: controller.postList[index],
                                      likePost: () => controller.likePost(
                                          controller.postList[index], index),
                                      commentCallback: () {
                                        showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          isScrollControlled: true,
                                          builder: (context) =>
                                              CustomBottomSheetComment(
                                            postId:
                                                controller.postList[index].id ??
                                                    "",
                                          ),
                                        );
                                      },
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
                            )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
