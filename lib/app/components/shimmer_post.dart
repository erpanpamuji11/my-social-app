import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mysocial_app/app/core/style/style_color.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerPost() {
  return ListView(
    shrinkWrap: true,
    children: List.generate(
      10,
      (index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: CustomColor.netral800),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    height: 16,
                    width: Get.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: CustomColor.netral800,
                    ),
                  )
                ],
              ),
              Gap(12),
              Container(
                height: 16,
                width: Get.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: CustomColor.netral800,
                ),
              ),
              Gap(8),
              Container(
                height: Get.height * 0.3,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: CustomColor.netral800,
                ),
              ),
              Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: CustomColor.netral800,
                      ),
                    ),
                    Gap(24),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: CustomColor.netral800,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(30)
            ],
          ),
        ),
      ),
    ),
  );
}
