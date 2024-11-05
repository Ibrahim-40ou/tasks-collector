import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:abm/resources/core/utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNotificationsShimmer extends StatelessWidget {
  const CustomNotificationsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
      color: isDarkMode
          ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
          : Theme.of(context).colorScheme.secondary.withOpacity(0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: const Color(0xFFCCCCCC),
            highlightColor: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 10.h,
                width: 20.w,
                color: const Color(0xFFCCCCCC),
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: const Color(0xFFCCCCCC),
                  highlightColor: Colors.white,
                  child: Container(
                    height: 2.h,
                    width: 100.w,
                    color: const Color(0xFFCCCCCC),
                  ),
                ),
                SizedBox(height: 0.2.h),
                Shimmer.fromColors(
                  baseColor: const Color(0xFFCCCCCC),
                  highlightColor: Colors.white,
                  child: Container(
                    height: 2.h,
                    width: 50.w,
                    color: const Color(0xFFCCCCCC),
                  ),
                ),
                SizedBox(height: 1.h),
                Container(
                  height: 2.h,
                  width: 15.w,
                  color: const Color(0xFFCCCCCC),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
