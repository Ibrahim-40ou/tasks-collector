import 'package:abm/resources/core/routing/routes.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: InitialRoute.page, initial: true),
        AutoRoute(page: Landing.page),
        AutoRoute(page: Login.page),
        AutoRoute(page: Register.page),
        AutoRoute(page: OTP.page),
        AutoRoute(page: App.page),
        AutoRoute(page: Settings.page),
        AutoRoute(page: Statistics.page),
        AutoRoute(page: Notifications.page),
        AutoRoute(page: ProfileInformation.page),
        AutoRoute(page: Tasks.page),
        AutoRoute(page: AddTaskRoute.page),
        AutoRoute(page: ImageViewer.page),
        AutoRoute(page: TaskDetails.page),
      ];
}
