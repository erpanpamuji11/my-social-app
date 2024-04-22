import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mysocial_app/app/core/style/style_color.dart';
import 'package:mysocial_app/app/core/style/style_text.dart';
import 'package:mysocial_app/app/core/utils/date_utils.dart';
import 'package:mysocial_app/app/modules/posting/controllers/comment_controller.dart';

class CustomBottomSheetComment extends GetView<CommentController> {
  const CustomBottomSheetComment({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    
    return GetBuilder(
      init: CommentController(),
      builder: (controller) {
        controller.postId = postId;
        controller.update();
        return Container(
          decoration: const BoxDecoration(
              color: CustomColor.primary100,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          height: Get.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Center(
                  child: Container(
                    height: 5,
                    width: Get.width * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColor.netral500,
                    ),
                  ),
                ),
                const Gap(20),
                Center(
                  child: Text(
                    "Komentar",
                    style: h4Bold(),
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    itemCount: controller.hasMore.value
                        ? controller.commentList.length + 1
                        : controller.commentList.length,
                    itemBuilder: (context, index) {
                      if (index < controller.commentList.length) {
                        return ListTile(
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
                                        .commentList[index].owner?.picture ??
                                    ""),
                              ),
                            ),
                          ),
                          title: Text(
                            controller.commentList[index].owner?.firstName ??
                                "",
                            style: b2Bold(),
                          ),
                          subtitle: Text(
                            controller.commentList[index].message ?? "",
                            style: b2Medium(),
                          ),
                          trailing: Text(
                            DatesUtils.formatDate(
                                controller.commentList[index].publishDate ??
                                    DateTime.now()),
                            style: b3Reguler(),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
