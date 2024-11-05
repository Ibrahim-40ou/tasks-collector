import 'dart:io';

import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/common_functions.dart';
import '../../../../core/utils/governorates.dart';
import '../../../../core/utils/image_selection_state/image_selection_bloc.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/text.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../user_information/domain/entities/user_entity.dart';
import '../state/bloc/user_information_bloc.dart';

@RoutePage()
class ProfileInformation extends StatelessWidget {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _governorate = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final _key = GlobalKey<FormState>();
  String? avatar;
  XFile? selectedImageFile;
  late UserEntity _initialUserInfo = UserEntity(
    name: '',
    phoneNumber: '',
    governorate: '',
    avatar: '',
  );

  ProfileInformation({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);

    return BlocProvider<ImageSelectionBloc>(
      create: (BuildContext context) => ImageSelectionBloc(),
      child: BlocConsumer<UserInformationBloc, UserInformationState>(
        listener: (BuildContext context, state) {
          if (state is UpdateUserInformationSuccess) {
            CommonFunctions().showSnackBar(context, 'profile updated'.tr());
          }
          if (state is UpdateUserInformationFailure) {
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
          if (state is FetchCurrentUserInformationSuccess) {
            _initialUserInfo = state.userData;
            _phoneNumber.text = _initialUserInfo.phoneNumber;
            _fullName.text = _initialUserInfo.name ?? '';
            _governorate.text = CommonFunctions()
                    .getGovernorateName(_initialUserInfo.governorate)
                    ?.tr() ??
                '';
            avatar = _initialUserInfo.avatar ?? '';
          }
          return WillPopScope(
            onWillPop: () async {
              context.read<ImageSelectionBloc>().add(StopImageSelection());
              return Future.value(true);
            },
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  leading: CustomBackButton(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    iconColor: Colors.white,
                    function: () {
                      context
                          .read<ImageSelectionBloc>()
                          .add(StopImageSelection());
                    },
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                body: SingleChildScrollView(
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        SizedBox(height: 18.h),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            _buildPageFields(
                              context,
                              state,
                              isDarkMode,
                            ),
                            _buildUserImageAndPageInfo(
                              context,
                              state,
                              isDarkMode,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserImageAndPageInfo(
    BuildContext context,
    UserInformationState state,
    bool isDarkMode,
  ) {
    return Positioned(
      top: -6.5.h,
      child: SizedBox(
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
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
                              selectedImageFile = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                              context.read<ImageSelectionBloc>().add(
                                    SelectImageRequest(
                                      selectedImages: [selectedImageFile],
                                    ),
                                  );
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
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                              selectedImageFile = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              context.read<ImageSelectionBloc>().add(
                                    SelectImageRequest(
                                      selectedImages: [selectedImageFile],
                                    ),
                                  );
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
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
              child: Container(
                height: 15.h,
                width: 15.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: isDarkMode
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.secondary,
                ),
                child: BlocBuilder<ImageSelectionBloc, ImageSelectionState>(
                  builder: (context, state) {
                    if (state is SelectImageSuccess) {
                      if (state.selectedImages[0] != null) {
                        selectedImageFile = state.selectedImages[0];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            File(selectedImageFile!.path),
                            fit: BoxFit.cover,
                          ),
                        );
                      } else if (selectedImageFile != null) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            File(selectedImageFile!.path),
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    }
                    return avatar != null && avatar!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: avatar!.contains('http')
                                ? CachedNetworkImage(
                                    imageUrl: avatar!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: CustomLoadingIndicator(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  )
                                : Image.file(
                                    File(avatar!),
                                    fit: BoxFit.cover,
                                  ),
                          )
                        : Icon(
                            Iconsax.user,
                            size: 6.5.w,
                            color: Colors.black,
                          );
                  },
                ),
              ),
            ),
            SizedBox(height: 1.h),
            CustomText(
              text: 'edit profile information'.tr(),
              size: 8.sp,
              weight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageFields(
      BuildContext context, UserInformationState state, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(5.w),
      height: 72.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(4.h),
          topLeft: Radius.circular(4.h),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 2.h),
          CustomField(
            controller: _fullName,
            labelText: 'full name'.tr(),
            isLast: true,
            validatorFunction: _validateField,
            // onChanged: ,
          ),
          SizedBox(height: 1.h),
          CustomField(
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
                                    _governorate.text =
                                        governoratesList[index].tr();
                                    context.router.popForced();
                                  },
                                  height: 6.h,
                                  color: isDarkMode
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
          ),
          SizedBox(height: 1.h),
          CustomField(
            controller: _phoneNumber,
            labelText: 'phone number'.tr(),
            enabled: false,
            isLast: true,
            type: TextInputType.number,
          ),
          SizedBox(height: 4.h),
          CustomButton(
            function: () {
              if (_key.currentState!.validate()) {
                context.read<UserInformationBloc>().add(
                      UpdateUserInformation(
                        fullName: _fullName.text,
                        avatar: selectedImageFile?.path ?? avatar ?? '',
                        governorate: CommonFunctions().getGovernorateNumber(
                              _governorate.text,
                              context,
                            ) ??
                            '',
                        phoneNumber: _phoneNumber.text,
                      ),
                    );
              }
            },
            disabled: state is UpdateUserInformationLoading ? true : false,
            height: 6.h,
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (state is UpdateUserInformationLoading)
                  Row(
                    children: [
                      CustomLoadingIndicator(
                        color: Colors.white,
                      ),
                      SizedBox(width: 2.w),
                    ],
                  ),
                CustomText(
                  text: 'save'.tr(),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _validateField(String? value) =>
      value == null || value.isEmpty ? 'this field is required'.tr() : null;
}
