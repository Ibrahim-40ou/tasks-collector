// import 'package:abm/resources/core/routing/pages/wrappers/notifications_wrapper.dart';
// import 'package:abm/resources/core/routing/pages/wrappers/settings_wrapper.dart';
// import 'package:abm/resources/core/routing/pages/wrappers/statistics_wrapper.dart';
// import 'package:abm/resources/core/routing/pages/wrappers/tasks_wrapper.dart';
// import 'package:abm/resources/core/sizing/size_config.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
//
// import '../../../features/notifications/presentation/pages/notifications.dart';
// import '../../../features/statistics/presentation/pages/statistics.dart';
// import '../../../features/tasks/presentation/pages/tasks.dart';
// import '../../../features/user_information/presentation/pages/settings.dart';
// // import '../routing_state/navigation_cubit.dart';
//
// @RoutePage()
// class App extends StatelessWidget {
//   App({super.key});
//
//   final PageController _pageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode =
//         Theme.of(context).brightness == Brightness.dark ? true : false;
//     return BlocProvider<NavigationCubit>(
//       create: (BuildContext context) => NavigationCubit(),
//       child: SafeArea(
//         child: Scaffold(
//           body: BlocBuilder<NavigationCubit, int>(
//             builder: (context, currentIndex) {
//               return PageView(
//                 physics: const NeverScrollableScrollPhysics(),
//                 controller: _pageController,
//                 onPageChanged: (index) {
//                   context.read<NavigationCubit>().changePage(index);
//                 },
//                 children: [
//                   TasksNavigatorPage(),
//                   NotificationsNavigatorPage(),
//                   StatisticsNavigatorPage(),
//                   SettingsNavigatorPage(),
//                 ],
//               );
//             },
//           ),
//           bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
//             builder: (context, currentIndex) {
//               return BottomNavigationBar(
//                 showSelectedLabels: false,
//                 showUnselectedLabels: false,
//                 backgroundColor: Theme.of(context).colorScheme.surface,
//                 onTap: (index) {
//                   _pageController.animateToPage(
//                     index,
//                     duration: const Duration(milliseconds: 1),
//                     curve: Curves.easeInOut,
//                   );
//                   context.read<NavigationCubit>().changePage(index);
//                 },
//                 currentIndex: currentIndex,
//                 items: [
//                   BottomNavigationBarItem(
//                     icon: Icon(
//                       Iconsax.home,
//                       size: 6.w,
//                       color: Theme.of(context).textTheme.bodyMedium!.color!,
//                     ),
//                     activeIcon: Icon(
//                       Iconsax.home_15,
//                       size: 6.w,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     label: 'Home',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(
//                       Iconsax.notification,
//                       size: 6.w,
//                       color: Theme.of(context).textTheme.bodyMedium!.color!,
//                     ),
//                     activeIcon: Icon(
//                       Iconsax.notification5,
//                       size: 6.w,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     label: 'Notifications',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(
//                       Iconsax.graph,
//                       size: 6.w,
//                       color: Theme.of(context).textTheme.bodyMedium!.color!,
//                     ),
//                     activeIcon: Icon(
//                       Iconsax.graph5,
//                       size: 6.w,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     label: 'Statistics',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: SvgPicture.asset(
//                       isDarkMode
//                           ? 'assets/images/dark_settings.svg'
//                           : 'assets/images/light_settings.svg',
//                       height: 6.w,
//                       width: 6.w,
//                     ),
//                     activeIcon: SvgPicture.asset(
//                       'assets/images/selected_settings.svg',
//                       height: 6.w,
//                       width: 6.w,
//                     ),
//                     label: 'Settings',
//                   ),
//                 ],
//                 selectedLabelStyle: GoogleFonts.cairo(
//                   color: Theme.of(context).colorScheme.primary,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 unselectedLabelStyle: GoogleFonts.cairo(
//                   color: Theme.of(context).colorScheme.primary,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 selectedItemColor: Theme.of(context).colorScheme.primary,
//                 unselectedItemColor: isDarkMode ? Colors.white : Colors.black,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class NavigationCubit extends Cubit<int> {
//   NavigationCubit() : super(0); // Default to the first tab (index 0)
//
//   // Method to change the page index
//   void changePage(int index) {
//     emit(index);
//   }
// }
//



import 'package:abm/resources/core/routing/routes.gr.dart';
import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';


@RoutePage()
class App extends StatelessWidget {
  App({super.key});


  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
    Theme.of(context).brightness == Brightness.dark ? true : false;
    return AutoTabsRouter(
      routes: [
        Tasks(),
        Notifications(),
        Statistics(),
        Settings(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Theme.of(context).colorScheme.surface,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            currentIndex: tabsRouter.activeIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Iconsax.home,
                  size: 6.w,
                  color: Theme.of(context).textTheme.bodyMedium!.color!,
                ),
                activeIcon: Icon(
                  Iconsax.home_15,
                  size: 6.w,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Iconsax.notification,
                  size: 6.w,
                  color: Theme.of(context).textTheme.bodyMedium!.color!,
                ),
                activeIcon: Icon(
                  Iconsax.notification5,
                  size: 6.w,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Iconsax.graph,
                  size: 6.w,
                  color: Theme.of(context).textTheme.bodyMedium!.color!,
                ),
                activeIcon: Icon(
                  Iconsax.graph5,
                  size: 6.w,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: 'Statistics',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  isDarkMode
                      ? 'assets/images/dark_settings.svg'
                      : 'assets/images/light_settings.svg',
                  height: 6.w,
                  width: 6.w,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/images/selected_settings.svg',
                  height: 6.w,
                  width: 6.w,
                ),
                label: 'Settings',
              ),
            ],
            selectedLabelStyle: GoogleFonts.cairo(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelStyle: GoogleFonts.cairo(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.normal,
            ),
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: isDarkMode ? Colors.white : Colors.black,
          ),
        );
      },
    );
  }
}