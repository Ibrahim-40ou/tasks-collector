import 'dart:io';

import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:abm/resources/core/widgets/back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/common_functions.dart';
import '../../loading_indicator.dart';
import '../../text.dart';
import '../state/cubit/image_viewer_cubit.dart';

@RoutePage()
class ImageViewer extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ImageViewer({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    CommonFunctions().changeStatusBarColor(
      false,
      isDarkMode,
      context,
      Colors.black,
    );
    return BlocProvider<ImageViewerCubit>(
      create: (context) => ImageViewerCubit(initialIndex),
      child: WillPopScope(
        onWillPop: () async {
          context.read<ImageViewerCubit>().reset();
          CommonFunctions().changeStatusBarColor(
            false,
            isDarkMode,
            context,
            null,
          );
          return Future.value(true);
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                _buildImageViewer(context),
                _buildImageViewerInfo(context, isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageViewer(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        child: BlocBuilder<ImageViewerCubit, int>(
          builder: (context, pageIndex) {
            final cubit = context.read<ImageViewerCubit>();
            return PageView.builder(
              itemCount: imageUrls.length,
              controller: cubit.pageController,
              onPageChanged: cubit.updateIndex,
              itemBuilder: (context, index) {
                return imageUrls[index].contains('http')
                    ? CachedNetworkImage(
                        imageUrl: imageUrls[index],
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Center(
                          child: CustomLoadingIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(
                            Icons.error,
                            color: Theme.of(context).colorScheme.error,
                            size: 6.w,
                          ),
                        ),
                      )
                    : Image.file(
                        File(imageUrls[index]),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.error,
                              color: Theme.of(context).colorScheme.error,
                              size: 6.w,
                            ),
                          );
                        },
                      );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageViewerInfo(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBackButton(
            function: () {
              CommonFunctions().changeStatusBarColor(
                false,
                isDarkMode,
                context,
                null,
              );
              context.read<ImageViewerCubit>().reset();
            },
            backgroundColor: Colors.black.withOpacity(0.5),
            iconColor: Colors.white,
          ),
          BlocBuilder<ImageViewerCubit, int>(
            builder: (context, pageIndex) {
              return Container(
                padding: EdgeInsets.symmetric(
                  vertical: 1.w,
                  horizontal: 2.w,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomText(
                  text: '${pageIndex + 1} / ${imageUrls.length}',
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
