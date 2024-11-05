import 'dart:async';
import 'dart:io';

import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:abm/resources/core/utils/common_functions.dart';
import 'package:abm/resources/core/widgets/back_button.dart';
import 'package:abm/resources/core/widgets/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/routing/routes.gr.dart';
import '../../../../core/services/internet_services.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../domain/entities/task_entity.dart';
import '../state/cubit/counter_opacity_cubit.dart';
import '../state/cubit/image_counter_cubit.dart';

@RoutePage()
class TaskDetails extends StatelessWidget {
  final TaskEntity task;

  const TaskDetails({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(2.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(),
                SizedBox(height: 2.h),
                _buildTask(context, isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTask(BuildContext context, bool isDarkMode) {
    final pageController = PageController();
    final counterOpacityCubit = CounterOpacityCubit();
    Timer? timer;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'task details'.tr(),
          size: 8.sp,
          weight: FontWeight.w500,
        ),
        SizedBox(height: 2.h),
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                : Theme.of(context).colorScheme.secondary.withOpacity(0.4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: '${CommonFunctions().getStatus(task.statusId)}_1'.tr(),
                color: Theme.of(context).colorScheme.primary,
                weight: FontWeight.w600,
                size: 6.sp,
              ),
              SizedBox(height: 1.h),
              CustomText(text: task.description),
              SizedBox(height: 1.h),
              Container(
                height: 25.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemCount: task.media.length,
                      onPageChanged: (pageIndex) {
                        context
                            .read<ImageCounterCubit>()
                            .changeImage(pageIndex);
                        counterOpacityCubit.showCounter();

                        timer?.cancel();
                        timer = Timer(Duration(seconds: 2), () {
                          counterOpacityCubit.hideCounter();
                        });
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.router.push(
                              ImageViewer(
                                imageUrls: task.media,
                                initialIndex: index,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0.5,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FutureBuilder<bool>(
                                future:
                                    ConnectionServices().isInternetAvailable(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CustomLoadingIndicator(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ); // Loading state
                                  }

                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Icon(Icons.error), // Handle error
                                    );
                                  }

                                  if (snapshot.data == true) {
                                    return CachedNetworkImage(
                                      imageUrl: task.media[index],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CustomLoadingIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child: Icon(
                                          Icons.error,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Image.file(
                                      File(task.media[index]),
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Icon(Icons.error),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<ImageCounterCubit, int>(
                      builder: (context, pageIndex) {
                        return BlocBuilder<CounterOpacityCubit, double>(
                          bloc: counterOpacityCubit,
                          builder: (context, opacity) {
                            return Positioned(
                              bottom: 1.h,
                              right: 2.w,
                              child: AnimatedOpacity(
                                opacity: opacity,
                                duration: const Duration(milliseconds: 300),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 1.w,
                                    horizontal: 2.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CustomText(
                                    text:
                                        '${pageIndex + 1}/${task.media.length}',
                                    color: Colors.white,
                                    size: 4.sp,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Iconsax.location,
              size: 6.w,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            SizedBox(width: 2.w),
            CustomText(
              text:
                  '${capitalizeFirstLetter(CommonFunctions().getGovernorateName(task.governorateId)!)}, ${task.address}',
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Iconsax.clock,
              size: 6.w,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            SizedBox(width: 2.w),
            CustomText(
              text: _formatDate(task.date),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate).toLocal();
    String formattedDate =
        DateFormat('yyyy-MM-dd, EEEE, hh:mm a').format(dateTime);
    return formattedDate;
  }

  String capitalizeFirstLetter(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }
}
