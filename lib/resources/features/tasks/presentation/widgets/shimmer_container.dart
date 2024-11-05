import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:abm/resources/core/utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomTasksShimmer extends StatelessWidget {
  const CustomTasksShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 1.h,
        horizontal: 2.5.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CommonFunctions().darkModeCheck(context)
            ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
            : Theme.of(context).colorScheme.secondary.withOpacity(0.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: const Color(0xFFCCCCCC),
            highlightColor: Colors.white,
            child: Container(
              width: 20.w,
              height: 1.h,
              color: const Color(0xFFCCCCCC),
            ),
          ),
          SizedBox(height: 2.h),
          Shimmer.fromColors(
            baseColor: const Color(0xFFCCCCCC),
            highlightColor: Colors.white,
            child: Container(
              width: 100.w,
              height: 1.h,
              color: const Color(0xFFCCCCCC),
            ),
          ),
          SizedBox(height: 1.h),
          Shimmer.fromColors(
            baseColor: const Color(0xFFCCCCCC),
            highlightColor: Colors.white,
            child: Container(
              width: 70.w,
              height: 1.h,
              color: const Color(0xFFCCCCCC),
            ),
          ),
          SizedBox(height: 2.h),
          Shimmer.fromColors(
            baseColor: const Color(0xFFCCCCCC),
            highlightColor: Colors.white,
            child: Container(
              width: 100.w,
              height: 25.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFCCCCCC),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
