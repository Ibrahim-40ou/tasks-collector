import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:abm/resources/core/utils/common_functions.dart';
import 'package:abm/resources/core/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final bool showPassword;
  final bool isLast;
  final bool isName;
  final TextInputType type;
  final double? width;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function? suffixIconFunction;
  final String? Function(String?)? validatorFunction;
  final bool? enabled;
  final FocusNode? focusNode;
  final Function(String?)? onChanged;
  final bool readOnly;
  final Function? onTap;

  const CustomField({
    super.key,
    required this.controller,
    required this.labelText,
    this.width,
    this.maxLines,
    this.isPassword = false,
    this.showPassword = false,
    this.isLast = false,
    this.isName = false,
    this.type = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconFunction,
    this.validatorFunction,
    this.enabled,
    this.focusNode,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: labelText,
          weight: FontWeight.bold,
          size: CommonFunctions().englishCheck(context)
              ? 5.5.sp
              : 5.sp,
        ),
        SizedBox(height: 1.h),
        SizedBox(
          width: width ?? 100.w,
          child: TextFormField(
            maxLines: maxLines,
            minLines: 1,
            onTap: () {
              if(onTap != null) {
                onTap!();
              }
            },
            readOnly: readOnly,
            onChanged: onChanged,
            focusNode: focusNode,
            enabled: enabled,
            controller: controller,
            obscureText: showPassword,
            textInputAction:
                isLast ? TextInputAction.done : TextInputAction.next,
            textCapitalization:
                isName ? TextCapitalization.sentences : TextCapitalization.none,
            keyboardType: type,
            style: GoogleFonts.cairo(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: labelText,
              hintStyle: GoogleFonts.cairo(
                color: isDarkMode
                    ? Theme.of(context).textTheme.bodyMedium?.color
                    : Theme.of(context).textTheme.labelMedium?.color,
                fontSize: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1,
                  color: isDarkMode
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .color!
                      .withOpacity(0.4),
                ),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              errorStyle: GoogleFonts.cairo(
                fontSize: 14,
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.normal,
              ),
              errorMaxLines: 10,
            ),
            validator: validatorFunction,
          ),
        ),
      ],
    );
  }
}
