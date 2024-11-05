import 'dart:io';

import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/routing/routes.gr.dart';
import '../../../../core/utils/common_functions.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/text.dart';
import '../../../auth/presentation/state/bloc/auth_bloc.dart';
import '../state/bloc/user_information_bloc.dart';

@RoutePage()
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    CommonFunctions().changeStatusBarColor(true, isDarkMode, context, null);
    return BlocConsumer<UserInformationBloc, UserInformationState>(
      listener: (BuildContext context, state) {
        if (state is FetchCurrentUserInformationFailure) {
          CommonFunctions().showDialogue(
            context,
            state.failure!,
            '',
            () {},
            () {},
          );
        }
      },
      builder: (BuildContext context, state) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                _buildBackground(context),
                _buildPageButtons(context, isDarkMode, state),
                _buildUserInfo(context, isDarkMode, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Container(
      height: 100.h,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildPageButtons(
    BuildContext context,
    bool isDarkMode,
    UserInformationState state,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(5.w),
        height: 65.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(4.h),
            topLeft: Radius.circular(4.h),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton(
                function: () {
                  context.router.push(ProfileInformation());
                },
                height: 6.h,
                color: isDarkMode
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.secondary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 4.w),
                        Icon(
                          Iconsax.user,
                          size: 6.w,
                          color: isDarkMode
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        SizedBox(width: 2.w),
                        CustomText(
                          text: 'profile information'.tr(),
                          color: isDarkMode
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          CommonFunctions().englishCheck(context)
                              ? Iconsax.arrow_right_3
                              : Iconsax.arrow_left_2,
                          size: 6.w,
                          color: isDarkMode
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        SizedBox(width: 4.w),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              CustomButton(
                function: () {
                  CommonFunctions().showLanguageBottomSheet(
                    context,
                    isDarkMode,
                  );
                },
                height: 6.h,
                color: isDarkMode
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.secondary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 4.w),
                        Icon(
                          Iconsax.language_square,
                          size: 6.w,
                          color: isDarkMode
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        SizedBox(width: 2.w),
                        CustomText(
                          text: 'language'.tr(),
                          color: isDarkMode
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              CustomButton(
                function: () {
                  CommonFunctions().showThemeBottomSheet(
                    context,
                    isDarkMode,
                  );
                },
                height: 6.h,
                color: isDarkMode
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.secondary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 4.w),
                        Icon(
                          Iconsax.sun_1,
                          size: 6.w,
                          color: isDarkMode
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        SizedBox(width: 2.w),
                        CustomText(
                          text: 'theme'.tr(),
                          color: isDarkMode
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LogoutSuccess) {
                    context.router.replaceAll([InitialRoute()]);
                  }
                  if (state is LogoutFailure) {
                    CommonFunctions().showDialogue(
                      context,
                      state.failure!,
                      '',
                      () {},
                      () {},
                    );
                  }
                },
                child: CustomButton(
                  function: () {
                    CommonFunctions().showDialogue(
                      context,
                      '',
                      'are you sure you want to log out?'.tr(),
                      () {},
                      () {
                        context.read<AuthBloc>().add(LogoutRequest());
                      },
                    );
                  },
                  height: 6.h,
                  color: isDarkMode
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                      : Theme.of(context).colorScheme.secondary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 4.w),
                          Icon(
                            Iconsax.logout,
                            size: 6.w,
                            color: isDarkMode
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                          SizedBox(width: 2.w),
                          CustomText(
                            text: 'logout'.tr(),
                            color: isDarkMode
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(
    BuildContext context,
    bool isDarkMode,
    UserInformationState state,
  ) {
    return Positioned(
      top: 16.5.h,
      child: Column(
        children: [
          if (state is FetchCurrentUserInformationSuccess) ...[
            Container(
              height: 15.h,
              width: 15.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: isDarkMode
                    ? Theme.of(context).colorScheme.tertiary
                    : Theme.of(context).colorScheme.secondary,
              ),
              child: state.userData.avatar != null &&
                      state.userData.avatar!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: state.userData.avatar!.contains('http')
                          ? CachedNetworkImage(
                              imageUrl: state.userData.avatar!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CustomLoadingIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            )
                          : Image.file(
                              File(state.userData.avatar!),
                              fit: BoxFit.cover,
                            ),
                    )
                  : Icon(
                      Iconsax.user,
                      size: 6.5.w,
                      color: Colors.black,
                    ),
            ),
            CustomText(
              text:
                  state.userData.name != null && state.userData.name!.isNotEmpty
                      ? state.userData.name!
                      : '',
              size: 10.sp,
              weight: FontWeight.w500,
            ),
          ] else ...[
            CircleAvatar(
              radius: 60,
              backgroundColor: isDarkMode
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.secondary,
              child: Center(
                child: Icon(
                  Iconsax.user,
                  size: 6.5.w,
                  color: Colors.black,
                ),
              ),
            ),
            CustomText(
              text: '',
              size: 10.sp,
              weight: FontWeight.w500,
            ),
          ],
        ],
      ),
    );
  }
}
