import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/common_functions.dart';
import '../../../../core/widgets/text.dart';

class CustomStatistic extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? number;
  final double? width;
  final Function function;
  final bool selected;

  const CustomStatistic({
    super.key,
    required this.width,
    required this.icon,
    required this.title,
    required this.number,
    required this.function,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);

    return GestureDetector(
      onTap: () {
        function();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width ?? 47.w,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : isDarkMode
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                  : Theme.of(context).colorScheme.secondary.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 6.w,
                  color: selected
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyMedium!.color!,
                ),
                SizedBox(width: 2.w),
                CustomText(
                  text: title == null ? '' : title!.tr(),
                  size: 7.sp,
                  weight: FontWeight.w500,
                  color: selected ? Colors.white : null,
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: number == null ? '' : number!,
                  size: 8.sp,
                  weight: FontWeight.w500,
                  color: selected ? Colors.white : null,
                ),
                SizedBox(width: 2.w),
                CustomText(
                  text: 'tasks'.tr(),
                  size: CommonFunctions().englishCheck(context) ? 5.sp : 4.sp,
                  color: selected ? Colors.white : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
