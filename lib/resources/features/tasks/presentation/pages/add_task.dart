import 'dart:io';

import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:abm/resources/core/widgets/back_button.dart';
import 'package:abm/resources/core/widgets/loading_indicator.dart';
import 'package:abm/resources/core/widgets/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/common_functions.dart';
import '../../../../core/utils/governorates.dart';
import '../../../../core/utils/image_selection_state/image_selection_bloc.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../data/models/task_model.dart';
import '../state/bloc/tasks_bloc.dart';
import '../state/cubit/image_deletion_cubit.dart';

@RoutePage()
class AddTaskPage extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final TextEditingController _governorate = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _description = TextEditingController();
  List<XFile?> images = [];
  final List<String> filesPaths = [];
  XFile? image;

  AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImageSelectionBloc>(
          create: (BuildContext context) => ImageSelectionBloc(),
        ),
        BlocProvider<TasksBloc>(
          create: (BuildContext context) => TasksBloc(),
        ),
        BlocProvider<ImageDeletionCubit>(
          create: (BuildContext context) => ImageDeletionCubit(),
        ),
      ],
      child: BlocConsumer<ImageSelectionBloc, ImageSelectionState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          if (state is SelectImageSuccess) {
            images = state.selectedImages;
          }
          return Builder(
            builder: (context) {
              return SafeArea(
                child: Scaffold(
                  body: Padding(
                    padding: EdgeInsets.all(5.w),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _key,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitles(context),
                            SizedBox(height: 2.h),
                            _buildGovernorateField(context),
                            SizedBox(height: 2.h),
                            _buildAddressField(context),
                            SizedBox(height: 2.h),
                            _buildDescriptionField(context),
                            SizedBox(height: 2.h),
                            BlocConsumer<TasksBloc, TasksStates>(
                              listener: (BuildContext context, addTaskState) {
                                if (addTaskState is AddTaskFailure) {
                                  CommonFunctions().showDialogue(
                                    context,
                                    addTaskState.failure!,
                                    '',
                                    () {},
                                    () {},
                                  );
                                } else if (addTaskState is AddTaskSuccess) {
                                  context.router.popForced(true);
                                  CommonFunctions().showSnackBar(
                                    context,
                                    'task added'.tr(),
                                  );
                                }
                              },
                              builder: (BuildContext context, addTaskState) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildImagesSection(
                                      context,
                                      CommonFunctions().darkModeCheck(context),
                                      addTaskState,
                                    ),
                                    SizedBox(height: 2.h),
                                    _buildAddTasksButton(
                                      context,
                                      addTaskState,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTitles(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomBackButton(
          function: () {
            context.read<ImageSelectionBloc>().add(StopImageSelection());
          },
        ),
        SizedBox(height: 2.h),
        CustomText(
          text: 'add task'.tr(),
          size: 8.sp,
          weight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildGovernorateField(BuildContext context) {
    return CustomField(
      validatorFunction: _validateField,
      controller: _governorate,
      labelText: 'governorate'.tr(),
      readOnly: true,
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Theme.of(context).colorScheme.surface,
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: CustomText(
                      text: 'governorates'.tr(),
                      size: 6.sp,
                      weight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 18,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 0.5.h,
                            horizontal: 1.w,
                          ),
                          child: CustomButton(
                            function: () {
                              _governorate.text = governoratesList[index].tr();
                              context.router.popForced();
                            },
                            height: 6.h,
                            color: CommonFunctions().darkModeCheck(context)
                                ? Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.2)
                                : Theme.of(context).colorScheme.secondary,
                            child: CustomText(
                              text: governoratesList[index].tr(),
                            ),
                          ),
                        );
                      },
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

  Widget _buildAddressField(BuildContext context) {
    return CustomField(
      controller: _address,
      labelText: 'address'.tr(),
      validatorFunction: _validateField,
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    return CustomField(
      controller: _description,
      labelText: 'description'.tr(),
      maxLines: 5,
      isLast: true,
      validatorFunction: _validateField,
    );
  }

  Widget _buildImagesSection(
    BuildContext context,
    bool isDarkMode,
    TasksStates state,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'add images'.tr(),
          size: CommonFunctions().englishCheck(context) ? 5.5.sp : 5.sp,
          weight: FontWeight.bold,
        ),
        SizedBox(height: 1.h),
        Container(
          height: 25.h,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                : Theme.of(context).colorScheme.secondary.withOpacity(0.4),
          ),
          child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  function: () {
                    showModalBottomSheet(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      context: context,
                      builder: (BuildContext contexts) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: CustomText(
                                  text: 'source'.tr(),
                                  size: 6.sp,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              CustomButton(
                                function: () async {
                                  image = await ImagePicker().pickImage(
                                    source: ImageSource.camera,
                                  );
                                  if (image != null) {
                                    images.add(image);
                                  }
                                  context.read<ImageSelectionBloc>().add(
                                        SelectImageRequest(
                                          selectedImages: images,
                                        ),
                                      );
                                  context
                                      .read<ImageDeletionCubit>()
                                      .setImages(images);
                                  context.router.popForced();
                                },
                                height: 6.h,
                                color: CommonFunctions().darkModeCheck(context)
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2)
                                    : Theme.of(context).colorScheme.secondary,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: 'camera'.tr(),
                                      ),
                                      Icon(
                                        Iconsax.camera,
                                        size: 6.w,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color!,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              CustomButton(
                                function: () async {
                                  List<XFile?> selectedImages =
                                      await ImagePicker().pickMultiImage();
                                  images.addAll(selectedImages);
                                  context.read<ImageSelectionBloc>().add(
                                        SelectImageRequest(
                                          selectedImages: images,
                                        ),
                                      );
                                  context
                                      .read<ImageDeletionCubit>()
                                      .setImages(images);
                                  context.router.popForced();
                                },
                                height: 6.h,
                                color: CommonFunctions().darkModeCheck(context)
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2)
                                    : Theme.of(context).colorScheme.secondary,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: 'gallery'.tr(),
                                      ),
                                      Icon(
                                        Iconsax.gallery,
                                        size: 6.w,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color!,
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
                  },
                  height: 25.h,
                  width: 15.w,
                  color: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Iconsax.add,
                    color: Theme.of(context).textTheme.bodyMedium!.color!,
                    size: 8.w,
                  ),
                ),
                SizedBox(width: 2.w),
                BlocBuilder<ImageDeletionCubit, List<XFile?>>(
                  builder: (context, imagesState) {
                    images = imagesState;
                    return imagesState.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Icon(
                                Iconsax.gallery,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!,
                                size: 8.w,
                              ),
                            ),
                          )
                        : Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: imagesState.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return imagesState[index] != null
                                      ? Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                height: 25.h,
                                                width: 70.w,
                                                File(imagesState[index]!.path),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              top: 0.5.h,
                                              right: 2.w,
                                              child: CustomButton(
                                                function: () {
                                                  context
                                                      .read<
                                                          ImageDeletionCubit>()
                                                      .deleteImage(index);
                                                },
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error,
                                                height: 3.h,
                                                width: 6.w,
                                                child: Icon(
                                                  Iconsax.minus,
                                                  color: Colors.white,
                                                  size: 6.w,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container();
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(width: 2.w),
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
        state is NoImagesState
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomText(
                    text: 'please add images'.tr(),
                    size: 4.5.sp,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  Widget _buildAddTasksButton(
    BuildContext context,
    TasksStates addTaskState,
  ) {
    return CustomButton(
      function: () {
        if (_key.currentState!.validate() && images.isNotEmpty) {
          context.read<TasksBloc>().add(
                AddTask(
                  task: TaskModel(
                    id: 0,
                    description: _description.text,
                    address: _address.text,
                    governorateId: CommonFunctions()
                            .getGovernorateNumber(_governorate.text, context) ??
                        '',
                    date: DateTime.now().toUtc().toIso8601String(),
                    media: images.map((image) => image!.path).toList(),
                    lat: '33',
                    lng: '44',
                    statusId: 1,
                  ),
                ),
              );
        } else if (images.isEmpty) {
          context.read<TasksBloc>().add(NoImages());
        }
      },
      disabled: addTaskState is AddTaskLoading ? true : false,
      height: 6.h,
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (addTaskState is AddTaskLoading) ...[
            CustomLoadingIndicator(color: Colors.white),
            SizedBox(width: 2.w),
          ],
          CustomText(
            text: 'add task'.tr(),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  String? _validateField(String? value) =>
      value == null || value.isEmpty ? 'this field is required'.tr() : null;
}
