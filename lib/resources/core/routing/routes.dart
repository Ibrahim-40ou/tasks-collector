// import 'package:abm/resources/core/routing/routes.gr.dart';
// import 'package:auto_route/auto_route.dart';
//
// @AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
// class AppRouter extends RootStackRouter {
//   @override
//   List<AutoRoute> get routes => [
//         AutoRoute(page: InitialRoute.page, initial: true),
//         AutoRoute(page: LandingRoute.page),
//         AutoRoute(page: Login.page),
//         AutoRoute(page: Register.page),
//         AutoRoute(page: OTP.page),
//         AutoRoute(page: App.page),
//         AutoRoute(page: Settings.page),
//         AutoRoute(page: Statistics.page),
//         AutoRoute(page: Notifications.page),
//         AutoRoute(page: ProfileInformation.page),
//         AutoRoute(page: Tasks.page),
//         AutoRoute(page: AddTaskRoute.page),
//         AutoRoute(page: ImageViewer.page),
//         AutoRoute(page: TaskDetails.page),
//       ];
// }

import 'package:abm/resources/core/routing/routes.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: InitialRoute.page, initial: true, path: '/initial'),
        AutoRoute(
          page: LandingNavigationRoute.page,
          path: '/landing',
          children: [
            AutoRoute(
              page: LandingRoute.page,
              initial: true,
              path: 'landing',
            ),
            AutoRoute(page: Login.page, path: 'login'),
            AutoRoute(page: Register.page, path: 'register'),
            AutoRoute(page: OTP.page, path: 'otp'),
          ],
        ),
        AutoRoute(
          page: App.page,
          path: '/app',
          children: [
            AutoRoute(
              page: TasksNavigatorRoute.page,
              path: 'tasksNavigator',
              children: [
                AutoRoute(
                  page: Tasks.page,
                  path: 'tasks',
                  initial: true,
                ),
                AutoRoute(page: AddTaskRoute.page, path: 'addTask'),
                AutoRoute(page: TaskDetails.page, path: 'details'),
                AutoRoute(page: ImageViewer.page, path: 'viewer'),
              ],
            ),
            AutoRoute(
              page: NotificationsNavigatorRoute.page,
              path: 'notificationsNavigator',
              children: [
                AutoRoute(
                  page: Notifications.page,
                  path: 'notifications',
                  initial: true,
                ),
                AutoRoute(page: TaskDetails.page, path: 'details'),
                AutoRoute(page: ImageViewer.page, path: 'viewer'),
              ],
            ),
            AutoRoute(
              page: StatisticsNavigatorRoute.page,
              path: 'statisticsNavigator',
              children: [
                AutoRoute(
                  page: Statistics.page,
                  path: 'statistics',
                  initial: true,
                ),
                AutoRoute(page: TaskDetails.page, path: 'details'),
                AutoRoute(page: ImageViewer.page, path: 'viewer'),
              ],
            ),
            AutoRoute(
              page: SettingsNavigatorRoute.page,
              path: 'settingsNavigator',
              children: [
                AutoRoute(
                  page: Settings.page,
                  path: 'settings',
                  initial: true,
                ),
                AutoRoute(page: ProfileInformation.page, path: 'profile'),
              ],
            ),
          ],
        ),
      ];
}
