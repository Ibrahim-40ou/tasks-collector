import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../utils/common_functions.dart';

@RoutePage()
class LandingNavigatorPage extends StatelessWidget {
  const LandingNavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    CommonFunctions().changeStatusBarColor(false, isDarkMode, context, null);
    return const AutoRouter();
  }
}
