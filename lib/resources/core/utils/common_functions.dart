import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../theme/colors.dart';
import '../theme/theme_state/theme_bloc.dart';
import '../widgets/button.dart';
import '../widgets/text.dart';
import 'governorates.dart';

class CommonFunctions {
  String getStatus(int id) {
    if (id == 1) {
      return 'pending';
    } else if (id == 2) {
      return 'in progress';
    } else if (id == 3) {
      return 'canceled';
    } else if (id == 4) {
      return 'done';
    } else {
      return '';
    }
  }

  void changeLanguage(BuildContext context, String code) {
    if (code == 'en') {
      context.setLocale(const Locale('en', 'US'));
      preferences!.setString('language', 'en');
    } else {
      preferences!.setString('language', 'ar');
      context.setLocale(const Locale('ar', 'DZ'));
    }
  }

  bool darkModeCheck(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  bool englishCheck(BuildContext context) {
    return Localizations.localeOf(context).toString() == 'en_US';
  }

  Locale getStartingLanguage() {
    return preferences!.getString('language') == null ||
            preferences!.getString('language') == 'en'
        ? const Locale('en', 'US')
        : const Locale('ar', 'DZ');
  }

  void initiateSystemThemes(bool isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
        statusBarColor:
            isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
  }

  String? getGovernorateNumber(String governorateName, BuildContext context) {
    if (Localizations.localeOf(context).toString() == 'en_US') {
      return governoratesNamesMapEnglish[governorateName.toLowerCase()];
    } else {
      return governoratesNamesMapArabic[governorateName];
    }
  }

  String? getGovernorateName(String? governorateNumber) {
    if (governorateNumber != null) {
      return governoratesNumbersMap[governorateNumber];
    } else {
      return null;
    }
  }

  void changeStatusBarColor(
    bool isPrimary,
    bool isDarkMode,
    BuildContext context,
    Color? color,
  ) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isPrimary
            ? Theme.of(context).colorScheme.primary
            : color ?? Theme.of(context).colorScheme.surface,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isPrimary
            ? Brightness.light
            : isDarkMode
                ? Brightness.light
                : Brightness.dark,
      ),
    );
  }

  void showDialogue(
    BuildContext context,
    String errorText,
    String message,
    Function exitDialogue,
    Function confirmFunction,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: CustomText(
            text: errorText.isNotEmpty
                ? 'error occurred'.tr()
                : 'confirmation'.tr(),
            color: errorText.isNotEmpty
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.primary,
          ),
          content: CustomText(
            text: errorText.isNotEmpty ? errorText : message,
            color: Colors.black,
          ),
          actions: <Widget>[
            CustomButton(
              function: () {
                context.router.popForced(true);
                confirmFunction();
              },
              color: Theme.of(context).colorScheme.primary,
              child: CustomText(
                text: errorText.isNotEmpty ? 'okay'.tr() : 'confirm'.tr(),
                color: Colors.white,
              ),
            ),
            errorText.isNotEmpty
                ? Container()
                : CustomButton(
                    border: true,
                    borderColor: Colors.black,
                    function: () {
                      context.router.popForced(true);
                      exitDialogue();
                    },
                    color: Colors.white,
                    child: CustomText(
                      text: 'cancel'.tr(),
                      color: Colors.black,
                    ),
                  ),
          ],
        );
      },
    );
  }

  void showThemeBottomSheet(BuildContext context, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (BuildContext context, ThemeState state) {
            isDarkMode = state is ThemeChanged ? state.isDarkMode : isDarkMode;
            return Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: 100.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: 'theme'.tr(),
                    size: 6.sp,
                    weight: FontWeight.w600,
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.3)
                          : Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(text: 'dark mode'.tr()),
                        Switch(
                          value: darkModeCheck(context),
                          onChanged: (value) {
                            context.read<ThemeBloc>().add(
                                  ChangeTheme(
                                    isDarkMode: value,
                                  ),
                                );
                          },
                          trackOutlineColor: MaterialStateProperty.all(
                            Theme.of(context).textTheme.bodyMedium!.color!,
                          ),
                          inactiveTrackColor: isDarkMode
                              ? Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.2)
                              : Theme.of(context).colorScheme.secondary,
                          activeTrackColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showLanguageBottomSheet(BuildContext context, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'language'.tr(),
                size: 6.sp,
                weight: FontWeight.w600,
              ),
              SizedBox(height: 1.h),
              CustomButton(
                function: () {
                  changeLanguage(context, 'ar');
                },
                height: 6.h,
                color: isDarkMode
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(text: 'arabic'.tr()),
                      Container(
                        height: 2.h,
                        width: 2.h,
                        padding: EdgeInsets.all(0.4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color!,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: englishCheck(context)
                                ? Colors.transparent
                                : Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              CustomButton(
                function: () {
                  changeLanguage(context, 'en');
                },
                height: 6.h,
                color: isDarkMode
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(text: 'english'.tr()),
                      Container(
                        height: 2.h,
                        width: 2.h,
                        padding: EdgeInsets.all(0.4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color!,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: englishCheck(context)
                                ? Theme.of(context).textTheme.bodyMedium!.color!
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String text) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(
          horizontal: 1.5.h,
          vertical: 5.w,
        ),
        content: Row(
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
              size: 6.w,
            ),
            SizedBox(width: 2.w),
            CustomText(
              text: text,
              weight: FontWeight.normal,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Theme.of(context).textTheme.bodyMedium!.color!,
      ),
    );
  }
}
