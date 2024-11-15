import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/routing/routes.gr.dart';
import '../../../../core/utils/common_functions.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/text.dart';
import '../state/cubit/timer_cubit.dart';

@RoutePage()
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CommonFunctions().changeStatusBarColor(false, isDarkMode, context, null);
    });
    return Builder(
      builder: (BuildContext context) {
        context.read<TimerCubit>().resetTimer();
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                _buildLogo(),
                _buildContainer(context, isDarkMode),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    return Expanded(
      child: Center(
        child: CustomText(
          text: 'ABM',
          size: 15.sp,
          weight: FontWeight.bold,
          align: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context, bool isDarkMode) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: isDarkMode
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: 35.h,
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: 'welcome to abm'.tr(),
                  weight: FontWeight.bold,
                  size: CommonFunctions().englishCheck(context) ? 7.5.sp : 7.sp,
                ),
              ],
            ),
            CustomText(
              text: 'either login or register to continue and use the app'.tr(),
              color: Theme.of(context).textTheme.labelMedium!.color,
              overflow: TextOverflow.visible,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  function: () {
                    CommonFunctions().showLanguageBottomSheet(
                      context,
                      isDarkMode,
                    );
                  },
                  width: 6.w,
                  color: Colors.transparent,
                  child: Icon(
                    Iconsax.language_square,
                    size: 6.w,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                CustomButton(
                  function: () {
                    CommonFunctions().showThemeBottomSheet(
                      context,
                      isDarkMode,
                    );
                  },
                  width: 6.w,
                  color: Colors.transparent,
                  child: Icon(
                    isDarkMode ? Iconsax.moon : Iconsax.sun_1,
                    size: 6.w,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0.5.h,
            ),
            CustomButton(
              function: () {
                context.router.push(Login());
              },
              height: 6.h,
              color: Theme.of(context).colorScheme.primary,
              child: CustomText(
                text: 'login'.tr(),
                color: Colors.white,
              ),
            ),
            SizedBox(height: 1.h),
            CustomButton(
              function: () {
                context.router.push(Register());
              },
              height: 6.h,
              color: Theme.of(context).colorScheme.primary,
              child: CustomText(
                text: 'register'.tr(),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
