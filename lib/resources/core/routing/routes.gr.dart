// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:abm/resources/core/routing/pages/app.dart' as _i2;
import 'package:abm/resources/core/routing/pages/initial_route.dart' as _i4;
import 'package:abm/resources/core/routing/pages/wrappers/landing_wrapper.dart'
    as _i6;
import 'package:abm/resources/core/routing/pages/wrappers/notifications_wrapper.dart'
    as _i10;
import 'package:abm/resources/core/routing/pages/wrappers/settings_wrapper.dart'
    as _i15;
import 'package:abm/resources/core/routing/pages/wrappers/statistics_wrapper.dart'
    as _i17;
import 'package:abm/resources/core/routing/pages/wrappers/tasks_wrapper.dart'
    as _i20;
import 'package:abm/resources/core/widgets/image_viewer/widget/image_viewer.dart'
    as _i3;
import 'package:abm/resources/features/auth/presentation/pages/landing.dart'
    as _i7;
import 'package:abm/resources/features/auth/presentation/pages/landing_navigation.dart'
    as _i5;
import 'package:abm/resources/features/auth/presentation/pages/login.dart'
    as _i8;
import 'package:abm/resources/features/auth/presentation/pages/otp.dart'
    as _i11;
import 'package:abm/resources/features/auth/presentation/pages/register.dart'
    as _i13;
import 'package:abm/resources/features/notifications/presentation/pages/notifications.dart'
    as _i9;
import 'package:abm/resources/features/statistics/presentation/pages/statistics.dart'
    as _i16;
import 'package:abm/resources/features/tasks/domain/entities/task_entity.dart'
    as _i24;
import 'package:abm/resources/features/tasks/presentation/pages/add_task.dart'
    as _i1;
import 'package:abm/resources/features/tasks/presentation/pages/task_details.dart'
    as _i18;
import 'package:abm/resources/features/tasks/presentation/pages/tasks.dart'
    as _i19;
import 'package:abm/resources/features/user_information/presentation/pages/profile.dart'
    as _i12;
import 'package:abm/resources/features/user_information/presentation/pages/settings.dart'
    as _i14;
import 'package:auto_route/auto_route.dart' as _i21;
import 'package:flutter/cupertino.dart' as _i23;
import 'package:flutter/material.dart' as _i22;

/// generated route for
/// [_i1.AddTaskPage]
class AddTaskRoute extends _i21.PageRouteInfo<AddTaskRouteArgs> {
  AddTaskRoute({
    _i22.Key? key,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          AddTaskRoute.name,
          args: AddTaskRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AddTaskRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<AddTaskRouteArgs>(orElse: () => const AddTaskRouteArgs());
      return _i1.AddTaskPage(key: args.key);
    },
  );
}

class AddTaskRouteArgs {
  const AddTaskRouteArgs({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return 'AddTaskRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.App]
class App extends _i21.PageRouteInfo<AppArgs> {
  App({
    _i22.Key? key,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          App.name,
          args: AppArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'App';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppArgs>(orElse: () => const AppArgs());
      return _i2.App(key: args.key);
    },
  );
}

class AppArgs {
  const AppArgs({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return 'AppArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.ImageViewer]
class ImageViewer extends _i21.PageRouteInfo<ImageViewerArgs> {
  ImageViewer({
    _i22.Key? key,
    required List<String> imageUrls,
    int initialIndex = 0,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          ImageViewer.name,
          args: ImageViewerArgs(
            key: key,
            imageUrls: imageUrls,
            initialIndex: initialIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'ImageViewer';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ImageViewerArgs>();
      return _i3.ImageViewer(
        key: args.key,
        imageUrls: args.imageUrls,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class ImageViewerArgs {
  const ImageViewerArgs({
    this.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  final _i22.Key? key;

  final List<String> imageUrls;

  final int initialIndex;

  @override
  String toString() {
    return 'ImageViewerArgs{key: $key, imageUrls: $imageUrls, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i4.InitialScreen]
class InitialRoute extends _i21.PageRouteInfo<void> {
  const InitialRoute({List<_i21.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i4.InitialScreen();
    },
  );
}

/// generated route for
/// [_i5.LandingNavigationScreen]
class LandingNavigationRoute extends _i21.PageRouteInfo<void> {
  const LandingNavigationRoute({List<_i21.PageRouteInfo>? children})
      : super(
          LandingNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingNavigationRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i5.LandingNavigationScreen();
    },
  );
}

/// generated route for
/// [_i6.LandingNavigatorPage]
class LandingNavigatorRoute extends _i21.PageRouteInfo<void> {
  const LandingNavigatorRoute({List<_i21.PageRouteInfo>? children})
      : super(
          LandingNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingNavigatorRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i6.LandingNavigatorPage();
    },
  );
}

/// generated route for
/// [_i7.LandingScreen]
class LandingRoute extends _i21.PageRouteInfo<void> {
  const LandingRoute({List<_i21.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i7.LandingScreen();
    },
  );
}

/// generated route for
/// [_i8.Login]
class Login extends _i21.PageRouteInfo<LoginArgs> {
  Login({
    _i22.Key? key,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          Login.name,
          args: LoginArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Login';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginArgs>(orElse: () => const LoginArgs());
      return _i8.Login(key: args.key);
    },
  );
}

class LoginArgs {
  const LoginArgs({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return 'LoginArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.Notifications]
class Notifications extends _i21.PageRouteInfo<NotificationsArgs> {
  Notifications({
    _i22.Key? key,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          Notifications.name,
          args: NotificationsArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Notifications';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationsArgs>(
          orElse: () => const NotificationsArgs());
      return _i9.Notifications(key: args.key);
    },
  );
}

class NotificationsArgs {
  const NotificationsArgs({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return 'NotificationsArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.NotificationsNavigatorPage]
class NotificationsNavigatorRoute extends _i21.PageRouteInfo<void> {
  const NotificationsNavigatorRoute({List<_i21.PageRouteInfo>? children})
      : super(
          NotificationsNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsNavigatorRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i10.NotificationsNavigatorPage();
    },
  );
}

/// generated route for
/// [_i11.OTP]
class OTP extends _i21.PageRouteInfo<OTPArgs> {
  OTP({
    _i22.Key? key,
    required String phoneNumber,
    required bool registering,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          OTP.name,
          args: OTPArgs(
            key: key,
            phoneNumber: phoneNumber,
            registering: registering,
          ),
          initialChildren: children,
        );

  static const String name = 'OTP';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OTPArgs>();
      return _i11.OTP(
        key: args.key,
        phoneNumber: args.phoneNumber,
        registering: args.registering,
      );
    },
  );
}

class OTPArgs {
  const OTPArgs({
    this.key,
    required this.phoneNumber,
    required this.registering,
  });

  final _i22.Key? key;

  final String phoneNumber;

  final bool registering;

  @override
  String toString() {
    return 'OTPArgs{key: $key, phoneNumber: $phoneNumber, registering: $registering}';
  }
}

/// generated route for
/// [_i12.ProfileInformation]
class ProfileInformation extends _i21.PageRouteInfo<ProfileInformationArgs> {
  ProfileInformation({
    _i22.Key? key,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          ProfileInformation.name,
          args: ProfileInformationArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileInformation';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileInformationArgs>(
          orElse: () => const ProfileInformationArgs());
      return _i12.ProfileInformation(key: args.key);
    },
  );
}

class ProfileInformationArgs {
  const ProfileInformationArgs({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return 'ProfileInformationArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.Register]
class Register extends _i21.PageRouteInfo<RegisterArgs> {
  Register({
    _i23.Key? key,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          Register.name,
          args: RegisterArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Register';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<RegisterArgs>(orElse: () => const RegisterArgs());
      return _i13.Register(key: args.key);
    },
  );
}

class RegisterArgs {
  const RegisterArgs({this.key});

  final _i23.Key? key;

  @override
  String toString() {
    return 'RegisterArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.Settings]
class Settings extends _i21.PageRouteInfo<void> {
  const Settings({List<_i21.PageRouteInfo>? children})
      : super(
          Settings.name,
          initialChildren: children,
        );

  static const String name = 'Settings';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i14.Settings();
    },
  );
}

/// generated route for
/// [_i15.SettingsNavigatorPage]
class SettingsNavigatorRoute extends _i21.PageRouteInfo<void> {
  const SettingsNavigatorRoute({List<_i21.PageRouteInfo>? children})
      : super(
          SettingsNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsNavigatorRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i15.SettingsNavigatorPage();
    },
  );
}

/// generated route for
/// [_i16.Statistics]
class Statistics extends _i21.PageRouteInfo<StatisticsArgs> {
  Statistics({
    _i22.Key? key,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          Statistics.name,
          args: StatisticsArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Statistics';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<StatisticsArgs>(orElse: () => const StatisticsArgs());
      return _i16.Statistics(key: args.key);
    },
  );
}

class StatisticsArgs {
  const StatisticsArgs({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return 'StatisticsArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.StatisticsNavigatorPage]
class StatisticsNavigatorRoute extends _i21.PageRouteInfo<void> {
  const StatisticsNavigatorRoute({List<_i21.PageRouteInfo>? children})
      : super(
          StatisticsNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'StatisticsNavigatorRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i17.StatisticsNavigatorPage();
    },
  );
}

/// generated route for
/// [_i18.TaskDetails]
class TaskDetails extends _i21.PageRouteInfo<TaskDetailsArgs> {
  TaskDetails({
    _i22.Key? key,
    _i24.TaskEntity? task,
    String? id,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          TaskDetails.name,
          args: TaskDetailsArgs(
            key: key,
            task: task,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'TaskDetails';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TaskDetailsArgs>(
          orElse: () => TaskDetailsArgs(id: pathParams.optString('id')));
      return _i18.TaskDetails(
        key: args.key,
        task: args.task,
        id: args.id,
      );
    },
  );
}

class TaskDetailsArgs {
  const TaskDetailsArgs({
    this.key,
    this.task,
    this.id,
  });

  final _i22.Key? key;

  final _i24.TaskEntity? task;

  final String? id;

  @override
  String toString() {
    return 'TaskDetailsArgs{key: $key, task: $task, id: $id}';
  }
}

/// generated route for
/// [_i19.Tasks]
class Tasks extends _i21.PageRouteInfo<TasksArgs> {
  Tasks({
    _i22.Key? key,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          Tasks.name,
          args: TasksArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Tasks';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TasksArgs>(orElse: () => const TasksArgs());
      return _i19.Tasks(key: args.key);
    },
  );
}

class TasksArgs {
  const TasksArgs({this.key});

  final _i22.Key? key;

  @override
  String toString() {
    return 'TasksArgs{key: $key}';
  }
}

/// generated route for
/// [_i20.TasksNavigatorPage]
class TasksNavigatorRoute extends _i21.PageRouteInfo<void> {
  const TasksNavigatorRoute({List<_i21.PageRouteInfo>? children})
      : super(
          TasksNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'TasksNavigatorRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i20.TasksNavigatorPage();
    },
  );
}
