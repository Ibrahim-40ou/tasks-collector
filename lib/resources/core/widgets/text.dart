import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:abm/resources/core/utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight weight;
  final Color? color;
  final TextAlign? align;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final int? maxLines;
  final FontStyle? fontStyle;
  final double? lineHeight;

  const CustomText({
    super.key,
    required this.text,
    this.size,
    this.weight = FontWeight.normal,
    this.color,
    this.align,
    this.overflow,
    this.decoration,
    this.maxLines,
    this.fontStyle,
    this.lineHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.cairo(
        fontSize: size ?? 5.5.sp,
        fontWeight: weight,
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        decoration: decoration,
        fontStyle: fontStyle,
        height: lineHeight,
      ),
      textAlign: align ??
          (CommonFunctions().englishCheck(context)
              ? TextAlign.left
              : TextAlign.right),
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
