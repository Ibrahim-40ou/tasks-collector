import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes.gr.dart';
import '../../../../core/utils/common_functions.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/text.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../state/bloc/auth_bloc.dart';
import '../state/cubit/timer_cubit.dart';

@RoutePage()
class Login extends StatelessWidget {
  final TextEditingController _phoneNumber = TextEditingController();
  final _key = GlobalKey<FormState>();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, state) {
        if (state is SendOTPFailure) {
          CommonFunctions().showDialogue(
            context,
            state.failure!,
            '',
            () {},
            () {},
          );
        }
        if (state is SendOTPSuccess) {
          context.read<TimerCubit>().resetTimer();
          context.router.push(
            OTP(
              phoneNumber: _phoneNumber.text.trim(),
              registering: false,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(),
                    SizedBox(height: 2.h),
                    _buildInformationalTexts(context),
                    SizedBox(height: 2.h),
                    _buildInputField(context),
                    Spacer(),
                    _buildSendButton(context, state),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInformationalTexts(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'step 1 of 2'.tr(),
          color: Theme.of(context).colorScheme.primary,
          weight: FontWeight.w500,
        ),
        SizedBox(height: 2.h),
        CustomText(
          text: 'enter your mobile number'.tr(),
          size: CommonFunctions().englishCheck(context) ? 11.sp : 8.sp,
          weight: FontWeight.bold,
          lineHeight: 0.1.h,
        ),
        SizedBox(height: 1.h),
        CustomText(
          text:
              "we'll send you a 6-digit verification code to your mobile number to confirm your account"
                  .tr(),
        ),
      ],
    );
  }

  Widget _buildInputField(BuildContext context) {
    return CustomField(
      controller: _phoneNumber,
      labelText: 'phone number'.tr(),
      type: TextInputType.number,
      validatorFunction: _validatePhoneNumber,
      isLast: true,
    );
  }

  Widget _buildSendButton(BuildContext context, AuthState state) {
    return CustomButton(
      function: () {
        if (_key.currentState!.validate()) {
          context.read<AuthBloc>().add(
                SendOTPRequest(
                  phoneNumber: _phoneNumber.text.trim(),
                ),
              );
        }
      },
      height: 6.h,
      disabled: state is SendOTPLoading ? true : false,
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state is SendOTPLoading) ...[
            CustomLoadingIndicator(color: Colors.white),
            SizedBox(width: 2.w),
          ],
          CustomText(
            text: 'send OTP'.tr(),
            color: Colors.white,
          ),
        ],
      ),
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
