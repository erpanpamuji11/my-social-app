import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mysocial_app/app/core/style/style_color.dart';
import 'package:mysocial_app/app/core/style/style_text.dart';
import 'package:mysocial_app/app/modules/user/models/post_user_model/post_item.dart';

class CustomPostLikedItem extends StatelessWidget {
  const CustomPostLikedItem(
      {super.key, required this.data, required this.likePost});

  final PostItem data;
  final Function() likePost;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(data.ownerPic),
                  ),
                ),
              ),
              const Gap(12),
              Text(data.userName)
            ],
          ),
          const Gap(12),
          Text(
            data.text,
            style: b2Medium(),
          ),
          const Gap(8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              data.image,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(12),
              Row(
                children: [
                  GestureDetector(
                    onTap: likePost,
                    child: const Icon(
                      CupertinoIcons.heart_fill,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    "${data.likes + 1}",
                    style: b2Medium(),
                  )
                ],
              ),
              const Gap(30),
              const Icon(
                CupertinoIcons.chat_bubble_text,
                color: CustomColor.netral600,
                size: 30,
              ),
            ],
          )
        ],
      ),
    );
  }
}
