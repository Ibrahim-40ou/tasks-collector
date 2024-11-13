import 'dart:io';

import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/routing/routes.gr.dart';
import '../../../../core/utils/common_functions.dart';
import '../../../../core/utils/governorates.dart';
import '../../../../core/utils/image_selection_state/image_selection_bloc.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/text.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../state/bloc/auth_bloc.dart';
import '../state/cubit/timer_cubit.dart';

@RoutePage()
class Register extends StatelessWidget {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _governorate = TextEditingController();
  final _key = GlobalKey<FormState>();
  XFile? _selectedImage;
  XFile? _reserveImage;

  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageSelectionBloc>(
      create: (BuildContext context) => ImageSelectionBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, state) {
          if (state is RegisterFailure) {
            CommonFunctions().showDialogue(
              context,
              '${state.failure}',
              '',
              () {},
              () {},
            );
          }
          if (state is RegisterSuccess) {
            context.read<TimerCubit>().resetTimer();
            context.router.push(
              OTP(
                phoneNumber: _phoneNumber.text,
                registering: true,
              ),
            );
          }
        },
        builder: (BuildContext context, state) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.all(5.w),
                child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(),
                        SizedBox(height: 2.h),
                        _buildInformationalTexts(context),
                        SizedBox(height: 2.h),
                        _buildImagePicker(context),
                        SizedBox(height: 2.h),
                        _buildTextFields(context),
                        SizedBox(height: 4.h),
                        _buildRegisterButton(context, state),
                        SizedBox(height: 2.h),
                        _buildPageHelperText(context),
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

  Widget _buildInformationalTexts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'register'.tr(),
          size: 8.5.sp,
          weight: FontWeight.bold,
        ),
        CustomText(text: 'create a new account'.tr()),
      ],
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          showModalBottomSheet(
            backgroundColor: Theme.of(context).colorScheme.surface,
            context: context,
            builder: (context) {
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
                        _selectedImage = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        context.read<ImageSelectionBloc>().add(
                              SelectImageRequest(
                                selectedImages: [_selectedImage],
                              ),
                            );
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        _selectedImage = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        context.read<ImageSelectionBloc>().add(
                              SelectImageRequest(
                                selectedImages: [_selectedImage],
                              ),
                            );
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          if (_selectedImage != null) {
            _reserveImage = _selectedImage;
          }
        },
        child: Container(
          height: 15.h,
          width: 15.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
          child: BlocBuilder<ImageSelectionBloc, ImageSelectionState>(
            builder: (context, state) {
              if (state is SelectImageSuccess &&
                  state.selectedImages[0] != null) {
                _selectedImage = state.selectedImages[0];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    File(_selectedImage!.path),
                    fit: BoxFit.cover,
                  ),
                );
              } else if (_reserveImage != null) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    File(_reserveImage!.path),
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                return Icon(
                  CupertinoIcons.person,
                  size: 6.w,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return Column(
      children: [
        CustomField(
          controller: _fullName,
          labelText: 'full name'.tr(),
        ),
        SizedBox(height: 2.h),
        CustomField(
          controller: _phoneNumber,
          labelText: 'phone number'.tr(),
          type: TextInputType.number,
          validatorFunction: _validatePhoneNumber,
          isLast: true,
        ),
        SizedBox(height: 2.h),
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
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context, AuthState state) {
    return CustomButton(
      function: () {
        if (_key.currentState!.validate()) {
          context.read<AuthBloc>().add(
                RegisterRequest(
                  fullName: _fullName.text.trim(),
                  phoneNumber: _phoneNumber.text.trim(),
                  governorate: CommonFunctions()
                          .getGovernorateNumber(_governorate.text, context) ??
                      '',
                  avatar: _selectedImage?.path ?? '',
                ),
              );
        }
      },
      height: 6.h,
      disabled: state is RegisterLoading ? true : false,
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (state is RegisterLoading)
            Row(
              children: [
                CustomLoadingIndicator(
                  color: Colors.white,
                ),
                SizedBox(width: 2.w),
              ],
            ),
          CustomText(
            text: 'register'.tr(),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildPageHelperText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(
          text: "already have an account?".tr(),
          weight: FontWeight.normal,
        ),
        GestureDetector(
          onTap: () {
            context.router.popForced();
          },
          child: CustomText(
            text: ' login'.tr(),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter a phone number'.tr();
    }
    final RegExp phoneRegex = RegExp(r'^(077|078|079|075)\d{8}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'enter a valid phone number'.tr();
    }
    return null;
  }
}
