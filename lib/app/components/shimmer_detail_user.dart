import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysocial_app/app/core/style/style_color.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerDetailUser() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
    highlightColor: Colors.grey.shade100,
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: CustomColor.netral800),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 16,
            width: Get.width * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: CustomColor.netral800,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 16,
            width: Get.width * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: CustomColor.netral800,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 16,
            width: Get.width * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: CustomColor.netral800,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 16,
            width: Get.width * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: CustomColor.netral800,
            ),
          )
        ],
      ),
    ),
  );
}
