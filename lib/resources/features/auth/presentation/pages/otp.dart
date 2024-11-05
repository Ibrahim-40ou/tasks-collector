import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/routing/routes.gr.dart';
import '../../../../core/utils/common_functions.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/text.dart';
import '../state/bloc/auth_bloc.dart';
import '../state/cubit/timer_cubit.dart';

@RoutePage()
class OTP extends StatelessWidget {
  final String phoneNumber;
  final bool registering;
  final _key = GlobalKey<FormState>();
  final TextEditingController _otp = TextEditingController();

  OTP({super.key, required this.phoneNumber, required this.registering});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, state) {
        if (state is LoginSuccess) {
          context.router.replaceAll([InitialRoute()]);
        }
        if (state is LoginFailure) {
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
                    _buildPinField(context),
                    Spacer(),
                    _buildResendCodeButton(context),
                    SizedBox(height: 1.h),
                    _buildLoginButton(context, state),
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
        registering
            ? Container()
            : CustomText(
                text: 'step 2 of 2'.tr(),
                color: Theme.of(context).colorScheme.primary,
                weight: FontWeight.w500,
              ),
        SizedBox(height: 2.h),
        CustomText(
          text: 'enter 6-digit verification code'.tr(),
          size: CommonFunctions().englishCheck(context) ? 12.sp : 9.sp,
          weight: FontWeight.bold,
          lineHeight: 0.1.h,
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              text: "enter the code sent to".tr(),
            ),
            CustomText(
              text: ' $phoneNumber',
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPinField(BuildContext context) {
    return PinCodeTextField(
      errorTextSpace: 30,
      appContext: context,
      length: 6,
      controller: _otp,
      keyboardType: TextInputType.number,
      cursorColor: Theme.of(context).colorScheme.primary,
      pinTheme: PinTheme(
        fieldWidth: 13.w,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        inactiveColor: Theme.of(context).textTheme.bodyMedium!.color,
        activeColor: Theme.of(context).colorScheme.primary,
        selectedColor: Theme.of(context).colorScheme.primary,
      ),
      validator: _validateOTP,
    );
  }

  Widget _buildResendCodeButton(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, timerState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: 'resend code in:'.tr(),
                  color: Theme.of(context).colorScheme.primary,
                ),
                CustomText(
                  text: ' ${timerState.remainingTime}',
                  color: Theme.of(context).colorScheme.primary,
                ),
                CustomText(
                  text: 's'.tr(),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            SizedBox(height: 1.h),
            CustomButton(
              disabled: timerState.isButtonDisabled,
              function: timerState.isButtonDisabled
                  ? () {}
                  : () {
                      context.read<TimerCubit>().resetTimer();
                      context.read<AuthBloc>().add(
                            SendOTPRequest(
                              phoneNumber: phoneNumber.trim(),
                            ),
                          );
                    },
              height: 6.h,
              color: timerState.isButtonDisabled
                  ? Colors.grey
                  : Theme.of(context).colorScheme.primary,
              child: CustomText(
                text: 'resend code'.tr(),
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoginButton(BuildContext context, AuthState state) {
    return CustomButton(
      function: () {
        if (_key.currentState!.validate()) {
          context.read<AuthBloc>().add(
                LoginRequest(
                  phoneNumber: phoneNumber,
                  otp: _otp.text.trim(),
                ),
              );
        }
      },
      height: 6.h,
      disabled: state is LoginLoading ? true : false,
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state is LoginLoading) ...[
            CustomLoadingIndicator(color: Colors.white),
            SizedBox(width: 2.w),
          ],
          CustomText(
            text: 'login'.tr(),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  String? _validateOTP(String? value) {
    if (value == null || value.isEmpty) return 'enter the OTP'.tr();
    if (value.length < 6) return 'OTP must be 6 digits'.tr();
    return null;
  }
}
