import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:mysocial_app/app/core/style/style_color.dart';
import 'package:mysocial_app/app/core/style/style_text.dart';
import 'package:mysocial_app/app/modules/liked/widgets/custom_post_item.dart';

import '../controllers/liked_controller.dart';

class LikedView extends GetView<LikedController> {
  const LikedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LikedController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColor.primary700,
            title: Text(
              'Favorite',
              style: h3Bold(colorText: CustomColor.primary100),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Obx(
            () => RefreshIndicator(
              onRefresh: () async {
                controller.getPostList();
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.postList.length,
                  separatorBuilder: (context, index) => const Gap(20),
                  itemBuilder: (context, index) {
                    return CustomPostLikedItem(
                      data: controller.postList[index],
                      likePost: () => controller.deletePost(index),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
