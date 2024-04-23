import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:mysocial_app/app/components/bottomsheet_comment.dart';
import 'package:mysocial_app/app/components/custom_post_item.dart';
import 'package:mysocial_app/app/components/shimmer_post.dart';
import 'package:mysocial_app/app/core/constants/constant_text.dart';
import 'package:mysocial_app/app/core/style/style_color.dart';
import 'package:mysocial_app/app/core/style/style_text.dart';

import '../controllers/posting_controller.dart';

class PostingView extends GetView<PostingController> {
  const PostingView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PostingController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColor.primary700,
            title: Text(
              ConstantText.post,
              style: h3Bold(colorText: CustomColor.primary100),
            ),
            automaticallyImplyLeading: false,
            actions: [
              Obx(
                () => IconButton(
                  onPressed: () {
                    controller.changeExpandTag();
                  },
                  icon: Icon(
                    controller.isExpandTag.value == true
                        ? Icons.filter_alt_rounded
                        : Icons.filter_alt_outlined,
                    color: CustomColor.primary100,
                  ),
                ),
              )
            ],
          ),
          body: Obx(() {
            return RefreshIndicator(
              onRefresh: () async {
                controller.refreshData();
              },
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  children: [
                    Visibility(
                      visible: controller.isExpandTag.value,
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.bounceIn,
                        height: Get.height * 0.1,
                        width: Get.width,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.tagList.length,
                          separatorBuilder: (context, index) => const Gap(12),
                          itemBuilder: (context, index) {
                            return ChoiceChip(
                              label: Text(controller.tagList[index].name),
                              selected: controller.tagList[index].isSelected,
                              onSelected: (value) {
                                controller.changeTags(value, index);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    const Gap(20),
                    controller.isLoading == true
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: shimmerPost(),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
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
                                      horizontal: 20),
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
                          ),
                    const Gap(20)
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
