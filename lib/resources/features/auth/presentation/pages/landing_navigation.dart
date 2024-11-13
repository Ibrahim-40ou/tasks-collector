import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LandingNavigationScreen extends StatelessWidget {
  const LandingNavigationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}


//TODO: DO this laterrrrr
// routerConfig: appRouter.config(deepLinkBuilder: (deepLink) {
//   if (deepLink.path.startsWith('/settings')) {
//     return deepLink;
//   } else {
//     return DeepLink.defaultPath;
//   }
// },),


// if (loggedIn) {
//   context.router.replaceAll([App()]);
// } else {
//   print('hey1');
//   context.router.pushNamed('/initial/landing');
//   print('hey2');
// }