import 'dart:async';
import 'dart:io';

import 'package:abm/resources/core/routing/routes.gr.dart';
import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:abm/resources/core/widgets/button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/common_functions.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/text.dart';
import '../../domain/entities/task_entity.dart';
import '../state/bloc/tasks_bloc.dart';
import '../state/cubit/image_counter_cubit.dart';
import '../state/cubit/counter_opacity_cubit.dart';
import '../widgets/shimmer_container.dart';

@RoutePage()
class Tasks extends StatelessWidget {
  late List<TaskEntity> tasks = [];

  Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    CommonFunctions().changeStatusBarColor(false, isDarkMode, context, null);
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            context
                .read<TasksBloc>()
                .add(SerializationEvent(isPagination: true));
          },
          child: BlocConsumer<TasksBloc, TasksStates>(
            listener: (BuildContext context, state) {
              if (state is DeleteTaskFailure) {
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
              if (state is FetchTasksSuccess) {
                tasks = state.tasks;
              }
              if (state is UploadedOfflineTasksLoading) {
                return _buildLoadingWidget(context);
              } else if (state is DeletedOfflineTasksLoading) {
                return _buildLoadingWidget(context);
              } else if (state is FetchTasksLoading) {
                return _buildLoadingWidget(context);
              } else if (state is FetchTasksFailure) {
                return _buildErrorMessage(context, state);
              } else {
                tasks = state is FetchTasksSuccess ? state.tasks : [];
                List<ImageCounterCubit> pageCubits = state is FetchTasksSuccess
                    ? List.generate(
                        tasks.length,
                        (index) => ImageCounterCubit(),
                      )
                    : [];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitles(context),
                    if (tasks.isEmpty) ...[
                      _buildNoTasks(context),
                    ],
                    _buildTasks(
                      context,
                      tasks,
                      isDarkMode,
                      pageCubits,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNoTasks(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: CustomText(text: 'there are no tasks'.tr()),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'tasks'.tr(),
              size: 8.sp,
              weight: FontWeight.w500,
            ),
            SizedBox(height: 2.h),
            CustomTasksShimmer(),
            SizedBox(height: 1.h),
            CustomTasksShimmer(),
            SizedBox(height: 1.h),
            CustomTasksShimmer(),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage(
    BuildContext context,
    FetchTasksFailure state,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: 'failed to fetch tasks:'.tr(),
            overflow: TextOverflow.visible,
          ),
          CustomText(
            text: ' ${state.failure}',
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }

  Widget _buildTitles(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: 'tasks'.tr(),
            size: 8.sp,
            weight: FontWeight.w500,
          ),
          CustomButton(
            function: () async {
              await context.router.push(AddTaskRoute());
            },
            height: 8.w,
            width: 8.w,
            color: Theme.of(context).colorScheme.surface,
            child: Icon(
              Iconsax.add,
              color: Theme.of(context).textTheme.bodyMedium!.color!,
              size: 8.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasks(
    BuildContext context,
    List<TaskEntity> tasks,
    bool isDarkMode,
    List<ImageCounterCubit> pageCubits,
  ) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          final pageController = PageController();
          final counterOpacityCubit = CounterOpacityCubit();
          Timer? timer;
          tasks.sort(
            (a, b) {
              DateTime dateA = DateTime.parse(a.date);
              DateTime dateB = DateTime.parse(b.date);
              return dateB.compareTo(dateA);
            },
          );

          return GestureDetector(
            onTap: () {
              context.router.push(
                TaskDetails(
                  task: tasks[index],
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDarkMode
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                      : Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text:
                              '${CommonFunctions().getStatus(tasks[index].statusId)}_1'
                                  .tr(),
                          color: Theme.of(context).colorScheme.primary,
                          weight: FontWeight.w600,
                          size: 6.sp,
                        ),
                        SizedBox(
                          height: 2.h,
                          width: 4.w,
                          child: BlocBuilder<TasksBloc, TasksStates>(
                            builder: (context, loadingState) {
                              return PopupMenuButton(
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      child: CustomButton(
                                        function: () {
                                          context.read<TasksBloc>().add(
                                                DeleteTask(
                                                  id: tasks[index].id,
                                                  index: index,
                                                ),
                                              );
                                          context.router.popForced();
                                        },
                                        color:
                                            Theme.of(context).colorScheme.error,
                                        disabled:
                                            loadingState is DeleteTaskLoading,
                                        child: loadingState is DeleteTaskLoading
                                            ? CustomLoadingIndicator(
                                                color: isDarkMode
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .color!
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .surface,
                                              )
                                            : CustomText(
                                                text: 'delete'.tr(),
                                                color: isDarkMode
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .color
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .surface,
                                              ),
                                      ),
                                    ),
                                  ];
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    CustomText(
                      text: tasks[index].description,
                      size: 5.sp,
                    ),
                    SizedBox(height: 1.h),

                    SizedBox(
                      height: 25.h,
                      width: 100.w,
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: pageController,
                            itemCount: tasks[index].media.length,
                            onPageChanged: (pageIndex) {
                              pageCubits[index].changeImage(pageIndex);
                              counterOpacityCubit.showCounter();
                              timer?.cancel();
                              timer = Timer(
                                Duration(seconds: 2),
                                () => counterOpacityCubit.hideCounter(),
                              );
                            },
                            itemBuilder: (context, mediaIndex) {
                              return GestureDetector(
                                onTap: () {
                                  context.router.push(
                                    ImageViewer(
                                      imageUrls: tasks[index].media,
                                      initialIndex: mediaIndex,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: tasks[index]
                                            .media[mediaIndex]
                                            .contains('http')
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                tasks[index].media[mediaIndex],
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: CustomLoadingIndicator(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) => Center(
                                              child: Icon(Icons.error),
                                            ),
                                          )
                                        : Image.file(
                                            File(
                                                tasks[index].media[mediaIndex]),
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                Center(
                                                    child: Icon(Icons.error)),
                                          ),
                                  ),
                                ),
                              );
                            },
                          ),
                          // Page Counter
                          BlocBuilder<ImageCounterCubit, int>(
                            bloc: pageCubits[index],
                            builder: (context, pageIndex) {
                              return BlocBuilder<CounterOpacityCubit, double>(
                                bloc: counterOpacityCubit,
                                builder: (context, opacity) {
                                  return Positioned(
                                    bottom: 1.h,
                                    right: 2.w,
                                    child: AnimatedOpacity(
                                      opacity: opacity,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.w, horizontal: 2.w),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: CustomText(
                                          text:
                                              '${pageIndex + 1}/${tasks[index].media.length}',
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
                    SizedBox(height: 1.h),
                    // Location and Date Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.location,
                              size: 5.w,
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            ),
                            SizedBox(width: 2.w),
                            CustomText(
                              text: tasks[index].address,
                              size: 4.5.sp,
                            ),
                          ],
                        ),
                        CustomText(
                          text: _formatDate(tasks[index].date),
                          size: 4.5.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(String isoDateString) {
    try {
      DateTime dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'")
          .parseUTC(isoDateString)
          .toLocal();
      DateTime now = DateTime.now();

      Duration difference = now.difference(dateTime);
      int daysDifference = difference.inDays;

      if (dateTime.year == now.year) {
        if (daysDifference == 0) {
          return DateFormat.jm().format(dateTime);
        } else if (daysDifference > 0 && daysDifference <= 7) {
          return DateFormat.E().format(dateTime);
        } else {
          return DateFormat.MMMd().format(dateTime);
        }
      } else {
        return '${dateTime.year}, ${DateFormat.MMM().format(dateTime)} ${dateTime.day}';
      }
    } catch (e) {
      return 'Invalid date';
    }
  }
}
