import 'dart:async';
import 'dart:io';

import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:abm/resources/core/widgets/text.dart';
import 'package:abm/resources/features/complaints/domain/entities/complaint_entity.dart';
import 'package:abm/resources/features/complaints/presentation/state/bloc/complaints_bloc.dart';
import 'package:abm/resources/features/statistics/presentation/state/statistics_bloc.dart';
import 'package:abm/resources/features/statistics/presentation/widgets/statistic.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/routing/routes.gr.dart';
import '../../../../core/services/internet_services.dart';
import '../../../../core/utils/common_functions.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../complaints/presentation/state/cubit/counter_opacity_cubit.dart';
import '../../../complaints/presentation/state/cubit/image_counter_cubit.dart';
import '../../../complaints/presentation/widgets/shimmer_container.dart';

@RoutePage()
class Statistics extends StatelessWidget {
  late bool _totalComplaints = true;
  late List<ComplaintEntity> complaints = [];

  Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    CommonFunctions().changeStatusBarColor(false, isDarkMode, context, null);
    return MultiBlocProvider(
      providers: [
        BlocProvider<StatisticsBloc>(
          create: (context) => StatisticsBloc(),
        ),
        BlocProvider<ComplaintsBloc>(
          create: (context) => ComplaintsBloc()..add(SerializationEvent()),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(2.w),
            child: BlocConsumer<StatisticsBloc, StatisticsStates>(
              listener:
                  (BuildContext context, StatisticsStates statisticsState) {},
              builder:
                  (BuildContext context, StatisticsStates statisticsState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitles(),
                    SizedBox(height: 1.h),
                    BlocBuilder<ComplaintsBloc, ComplaintsStates>(
                      builder: (
                        BuildContext context,
                        ComplaintsStates complaintsState,
                      ) {
                        if (complaintsState is FetchComplaintsSuccess) {
                          complaints = complaintsState.complaints;
                        }
                        List<ImageCounterCubit> pageCubits = List.generate(
                          complaints.length,
                          (index) => ImageCounterCubit(),
                        );
                        return Expanded(
                          child: ListView(
                            children: [
                              _buildStatistics(
                                context,
                                isDarkMode,
                                statisticsState,
                                complaints,
                              ),
                              SizedBox(height: 1.h),
                              if (complaintsState
                                  is FetchComplaintsLoading) ...[
                                _buildLoadingWidget(context)
                              ],
                              if (complaintsState
                              is UploadedOfflineComplaintsLoading) ...[
                                _buildLoadingWidget(context)
                              ],
                              if (complaintsState
                              is DeletedOfflineComplaintsLoading) ...[
                                _buildLoadingWidget(context)
                              ],
                              _buildComplaints(
                                context,
                                isDarkMode,
                                pageCubits,
                                statisticsState is TotalComplaints
                                    ? statisticsState.complaints
                                    : statisticsState is ApprovedComplaints
                                        ? statisticsState.complaints
                                        : statisticsState is PendingComplaints
                                            ? statisticsState.complaints
                                            : statisticsState
                                                    is RejectedComplaints
                                                ? statisticsState.complaints
                                                : statisticsState
                                                        is ProcessingComplaints
                                                    ? statisticsState.complaints
                                                    : complaints,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomComplaintsShimmer(),
          SizedBox(height: 1.h),
          CustomComplaintsShimmer(),
          SizedBox(height: 1.h),
          CustomComplaintsShimmer(),
        ],
      ),
    );
  }

  Widget _buildTitles() {
    return CustomText(
      text: 'statistics'.tr(),
      size: 8.sp,
      weight: FontWeight.w500,
    );
  }

  Widget _buildStatistics(
    BuildContext context,
    bool isDarkMode,
    StatisticsStates state,
    List<ComplaintEntity> complaints,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomStatistic(
          width: 100.w,
          icon: Iconsax.book,
          title: 'total tasks'.tr(),
          number: '${complaints.length}',
          function: () {
            context.read<StatisticsBloc>().add(
                  TotalComplaintsEvent(complaints: complaints),
                );
            _totalComplaints = true;
          },
          selected: state is TotalComplaints || _totalComplaints,
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomStatistic(
              width: null,
              icon: Iconsax.tick_circle,
              title: 'done_2',
              number:
                  '${complaints.where((complaint) => complaint.statusId == 4).toList().length}',
              function: () {
                context.read<StatisticsBloc>().add(
                      ApprovedComplaintsEvent(complaints: complaints),
                    );
                _totalComplaints = false;
              },
              selected: state is ApprovedComplaints,
            ),
            SizedBox(width: 2.w),
            CustomStatistic(
              width: null,
              icon: Iconsax.info_circle,
              title: 'pending_2',
              number:
                  '${complaints.where((complaint) => complaint.statusId == 1).toList().length}',
              function: () {
                context.read<StatisticsBloc>().add(
                      PendingComplaintsEvent(complaints: complaints),
                    );
                _totalComplaints = false;
              },
              selected: state is PendingComplaints,
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomStatistic(
              width: null,
              icon: Iconsax.close_circle,
              title: 'canceled_2',
              number:
                  '${complaints.where((complaint) => complaint.statusId == 3).toList().length}',
              function: () {
                context.read<StatisticsBloc>().add(
                      RejectedComplaintsEvent(complaints: complaints),
                    );
                _totalComplaints = false;
              },
              selected: state is RejectedComplaints,
            ),
            SizedBox(width: 2.w),
            CustomStatistic(
              width: null,
              icon: Iconsax.activity,
              title: 'in progress_2',
              number:
                  '${complaints.where((complaint) => complaint.statusId == 2).toList().length}',
              function: () {
                context.read<StatisticsBloc>().add(
                      ProcessingComplaintsEvent(complaints: complaints),
                    );
                _totalComplaints = false;
              },
              selected: state is ProcessingComplaints,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildComplaints(
    BuildContext context,
    bool isDarkMode,
    List<ImageCounterCubit> pageCubits,
    List<ComplaintEntity> complaints,
  ) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: complaints.length,
      itemBuilder: (BuildContext context, int index) {
        final pageController = PageController();
        final counterOpacityCubit = CounterOpacityCubit();
        Timer? timer;

        complaints.sort(
          (a, b) {
            DateTime dateA = DateTime.parse(a.date);
            DateTime dateB = DateTime.parse(b.date);
            return dateB.compareTo(dateA);
          },
        );

        return GestureDetector(
          onTap: () {
            context.router.push(
              ComplaintDetails(
                complaint: complaints[index],
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 1.h,
              horizontal: 2.5.w,
            ),
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
                  text:
                      '${CommonFunctions().getStatus(complaints[index].statusId)}_1'
                          .tr(),
                  color: Theme.of(context).colorScheme.primary,
                  weight: FontWeight.w600,
                ),
                SizedBox(height: 1.h),
                CustomText(
                  text: complaints[index].description,
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
                        itemCount: complaints[index].media.length,
                        onPageChanged: (pageIndex) {
                          pageCubits[index].changeImage(pageIndex);
                          counterOpacityCubit.showCounter();
                          timer?.cancel();
                          timer = Timer(
                            Duration(seconds: 2),
                            () {
                              counterOpacityCubit.hideCounter();
                            },
                          );
                        },
                        itemBuilder: (context, mediaIndex) {
                          return GestureDetector(
                            onTap: () {
                              context.router.push(
                                ImageViewer(
                                  imageUrls: complaints[index].media,
                                  initialIndex: mediaIndex,
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
                                  future: ConnectionServices()
                                      .isInternetAvailable(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CustomLoadingIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      );
                                    }

                                    if (snapshot.hasError) {
                                      return Center(
                                        child:
                                            Icon(Icons.error), // Handle error
                                      );
                                    }

                                    if (snapshot.data == true) {
                                      return CachedNetworkImage(
                                        imageUrl:
                                            complaints[index].media[mediaIndex],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return Center(
                                            child: CustomLoadingIndicator(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return Center(
                                            child: Icon(Icons.error),
                                          );
                                        },
                                      );
                                    } else {
                                      return Image.file(
                                        File(complaints[index]
                                            .media[mediaIndex]),
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
                                          '${pageIndex + 1}/${complaints[index].media.length}',
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
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        SizedBox(width: 2.w),
                        CustomText(
                          text: complaints[index].address,
                          size: 4.5.sp,
                        ),
                      ],
                    ),
                    CustomText(
                      text: _formatDate(complaints[index].date),
                      size: 4.5.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 1.h);
      },
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
