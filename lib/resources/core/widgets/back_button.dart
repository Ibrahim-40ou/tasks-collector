import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class CustomBackButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final Function? function;

  const CustomBackButton({
    super.key,
    this.backgroundColor,
    this.iconColor,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      function: () {
        context.router.popForced(true);
        if(function != null) {
          function!();
        }
      },
      color: backgroundColor != null
          ? backgroundColor!
          : Theme.of(context).colorScheme.secondary.withOpacity(0.2),
      width: 12.w,
      height: 6.h,
      child: Icon(
        CupertinoIcons.back,
        color: iconColor != null
            ? iconColor!
            : Theme.of(context).textTheme.bodyMedium!.color,
      ),
    );
  }
}
