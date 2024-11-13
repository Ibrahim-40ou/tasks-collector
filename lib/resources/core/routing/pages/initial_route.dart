import 'package:abm/main.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../widgets/loading_indicator.dart';
import '../routes.gr.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool loggedIn = preferences!.getBool('loggedIn') ?? false;
    if (loggedIn) {
      context.router.replaceAll([App()]);
    } else {
      context.router.replaceAll([LandingNavigationRoute()]);

    }
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: CustomLoadingIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}


