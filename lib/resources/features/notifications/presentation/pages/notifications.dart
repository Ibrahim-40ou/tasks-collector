import 'dart:io';

import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:abm/resources/features/notifications/presentation/widgets/notifications_shimmer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes.gr.dart';

import '../../../../core/utils/common_functions.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/text.dart';
import '../../../tasks/domain/entities/task_entity.dart';
import '../../../tasks/presentation/state/bloc/tasks_bloc.dart';

@RoutePage()
class Notifications extends StatelessWidget {
  late List<TaskEntity> tasks = [];

  Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    return BlocConsumer<TasksBloc, TasksStates>(
      listener: (BuildContext context, TasksStates state) {},
      builder: (BuildContext context, TasksStates state) {
        if (state is FetchTasksSuccess) {
          tasks = state.tasks;
        }
        return SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTitles(),
                (state is FetchTasksLoading)
                    ? _buildLoadingNotifications(context, isDarkMode)
                    : (state is UploadedOfflineTasksLoading)
                        ? _buildLoadingNotifications(context, isDarkMode)
                        : (state is DeletedOfflineTasksLoading)
                            ? _buildLoadingNotifications(context, isDarkMode)
                            : _buildNotifications(context, isDarkMode),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitles() {
    return Padding(
      padding: EdgeInsets.all(2.w),
      child: CustomText(
        text: 'notifications'.tr(),
        size: 8.sp,
        weight: FontWeight.w500,
      ),
    );
  }

  Widget _buildLoadingNotifications(BuildContext context, bool isDarkMode) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNotificationsShimmer(),
          SizedBox(height: 1.h),
          CustomNotificationsShimmer(),
          SizedBox(height: 1.h),
          CustomNotificationsShimmer(),
        ],
      ),
    );
  }

  Widget _buildNotifications(BuildContext context, bool isDarkMode) {
    return Expanded(
      child: ListView.separated(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              context.router.push(
                TaskDetails(
                  task: tasks[index],
                ),
              );
            },
            child: Container(
              width: 100.w,
              height: 12.5.h,
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                  : Theme.of(context).colorScheme.secondary.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                    width: 10.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: tasks[index].media[0].contains('http')
                          ? CachedNetworkImage(
                              imageUrl: tasks[index].media[0],
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return Center(
                                  child: CustomLoadingIndicator(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) {
                                return Center(
                                  child: Icon(Icons.error),
                                );
                              },
                            )
                          : Image.file(
                              File(tasks[index].media[0]),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(Icons.error),
                                );
                              },
                            ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text:
                              'Your task submitted on 2024-11-03 in Baghdad has been approved and we are working on it.'
                                  .tr(),
                          size: 5.sp,
                        ),
                        SizedBox(height: 1.h),
                        CustomText(
                          text: _formatDate(tasks[index].date),
                          size: 4.5.sp,
                          color:
                              Theme.of(context).textTheme.labelMedium!.color!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 1.h);
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
