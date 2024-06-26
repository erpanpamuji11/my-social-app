import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mysocial_app/app/core/style/style_color.dart';
import 'package:mysocial_app/app/core/style/style_text.dart';
import 'package:mysocial_app/app/modules/user/models/post_user_model/post_user_model.dart';
import 'package:shimmer/shimmer.dart';

class CustomPostItem extends StatelessWidget {
  const CustomPostItem(
      {super.key,
      required this.data,
      required this.likePost,
      this.commentCallback});

  final PostUserModel data;
  final Function() likePost;
  final Function()? commentCallback;

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
                    image: NetworkImage(data.owner?.picture ?? ""),
                  ),
                ),
              ),
              const Gap(12),
              Text(data.owner?.firstName ?? "")
            ],
          ),
          const Gap(12),
          Text(
            data.text ?? "",
            style: b2Medium(),
          ),
          const Gap(8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              key: UniqueKey(),
              imageUrl: data.image ?? "",
              fit: BoxFit.fill,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: Get.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColor.primary100,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
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
                    child: Icon(
                      data.liked == true
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    data.likes.toString(),
                    style: b2Medium(),
                  )
                ],
              ),
              const Gap(30),
              GestureDetector(
                onTap: commentCallback,
                child: const Icon(
                  CupertinoIcons.chat_bubble_text,
                  color: CustomColor.netral600,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
