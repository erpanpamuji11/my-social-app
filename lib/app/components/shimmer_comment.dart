import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysocial_app/app/core/style/style_color.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerComment() {
  return ListView(
    shrinkWrap: true,
    children: List.generate(
      2,
      (index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: const Color.fromARGB(255, 2, 2, 2),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: CustomColor.primary100),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                height: 16,
                width: Get.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: CustomColor.primary100,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
