// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:abm/resources/core/routing/pages/app.dart' as _i2;
import 'package:abm/resources/core/routing/pages/initial_route.dart' as _i4;
import 'package:abm/resources/core/widgets/image_viewer/widget/image_viewer.dart'
    as _i3;
import 'package:abm/resources/features/auth/presentation/pages/landing.dart'
    as _i5;
import 'package:abm/resources/features/auth/presentation/pages/login.dart'
    as _i6;
import 'package:abm/resources/features/auth/presentation/pages/otp.dart' as _i8;
import 'package:abm/resources/features/auth/presentation/pages/register.dart'
    as _i10;
import 'package:abm/resources/features/notifications/presentation/pages/notifications.dart'
    as _i7;
import 'package:abm/resources/features/statistics/presentation/pages/statistics.dart'
    as _i12;
import 'package:abm/resources/features/tasks/domain/entities/task_entity.dart'
    as _i18;
import 'package:abm/resources/features/tasks/presentation/pages/add_task.dart'
    as _i1;
import 'package:abm/resources/features/tasks/presentation/pages/task_details.dart'
    as _i13;
import 'package:abm/resources/features/tasks/presentation/pages/tasks.dart'
    as _i14;
import 'package:abm/resources/features/user_information/presentation/pages/profile.dart'
    as _i9;
import 'package:abm/resources/features/user_information/presentation/pages/settings.dart'
    as _i11;
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/cupertino.dart' as _i17;
import 'package:flutter/material.dart' as _i16;

/// generated route for
/// [_i1.AddTaskPage]
class AddTaskRoute extends _i15.PageRouteInfo<AddTaskRouteArgs> {
  AddTaskRoute({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          AddTaskRoute.name,
          args: AddTaskRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AddTaskRoute';

  static _i15.PageInfo page = _i15.PageInfo(
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

  final _i16.Key? key;

  @override
  String toString() {
    return 'AddTaskRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.App]
class App extends _i15.PageRouteInfo<AppArgs> {
  App({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          App.name,
          args: AppArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'App';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppArgs>(orElse: () => const AppArgs());
      return _i2.App(key: args.key);
    },
  );
}

class AppArgs {
  const AppArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'AppArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.ImageViewer]
class ImageViewer extends _i15.PageRouteInfo<ImageViewerArgs> {
  ImageViewer({
    _i16.Key? key,
    required List<String> imageUrls,
    int initialIndex = 0,
    List<_i15.PageRouteInfo>? children,
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

  static _i15.PageInfo page = _i15.PageInfo(
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

  final _i16.Key? key;

  final List<String> imageUrls;

  final int initialIndex;

  @override
  String toString() {
    return 'ImageViewerArgs{key: $key, imageUrls: $imageUrls, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i4.InitialScreen]
class InitialRoute extends _i15.PageRouteInfo<void> {
  const InitialRoute({List<_i15.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.InitialScreen();
    },
  );
}

/// generated route for
/// [_i5.Landing]
class Landing extends _i15.PageRouteInfo<void> {
  const Landing({List<_i15.PageRouteInfo>? children})
      : super(
          Landing.name,
          initialChildren: children,
        );

  static const String name = 'Landing';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i5.Landing();
    },
  );
}

/// generated route for
/// [_i6.Login]
class Login extends _i15.PageRouteInfo<LoginArgs> {
  Login({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          Login.name,
          args: LoginArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Login';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginArgs>(orElse: () => const LoginArgs());
      return _i6.Login(key: args.key);
    },
  );
}

class LoginArgs {
  const LoginArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'LoginArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.Notifications]
class Notifications extends _i15.PageRouteInfo<NotificationsArgs> {
  Notifications({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          Notifications.name,
          args: NotificationsArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Notifications';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationsArgs>(
          orElse: () => const NotificationsArgs());
      return _i7.Notifications(key: args.key);
    },
  );
}

class NotificationsArgs {
  const NotificationsArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'NotificationsArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.OTP]
class OTP extends _i15.PageRouteInfo<OTPArgs> {
  OTP({
    _i16.Key? key,
    required String phoneNumber,
    required bool registering,
    List<_i15.PageRouteInfo>? children,
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

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OTPArgs>();
      return _i8.OTP(
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

  final _i16.Key? key;

  final String phoneNumber;

  final bool registering;

  @override
  String toString() {
    return 'OTPArgs{key: $key, phoneNumber: $phoneNumber, registering: $registering}';
  }
}

/// generated route for
/// [_i9.ProfileInformation]
class ProfileInformation extends _i15.PageRouteInfo<ProfileInformationArgs> {
  ProfileInformation({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ProfileInformation.name,
          args: ProfileInformationArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileInformation';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileInformationArgs>(
          orElse: () => const ProfileInformationArgs());
      return _i9.ProfileInformation(key: args.key);
    },
  );
}

class ProfileInformationArgs {
  const ProfileInformationArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'ProfileInformationArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.Register]
class Register extends _i15.PageRouteInfo<RegisterArgs> {
  Register({
    _i17.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          Register.name,
          args: RegisterArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Register';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<RegisterArgs>(orElse: () => const RegisterArgs());
      return _i10.Register(key: args.key);
    },
  );
}

class RegisterArgs {
  const RegisterArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'RegisterArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.Settings]
class Settings extends _i15.PageRouteInfo<void> {
  const Settings({List<_i15.PageRouteInfo>? children})
      : super(
          Settings.name,
          initialChildren: children,
        );

  static const String name = 'Settings';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i11.Settings();
    },
  );
}

/// generated route for
/// [_i12.Statistics]
class Statistics extends _i15.PageRouteInfo<StatisticsArgs> {
  Statistics({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          Statistics.name,
          args: StatisticsArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Statistics';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<StatisticsArgs>(orElse: () => const StatisticsArgs());
      return _i12.Statistics(key: args.key);
    },
  );
}

class StatisticsArgs {
  const StatisticsArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'StatisticsArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.TaskDetails]
class TaskDetails extends _i15.PageRouteInfo<TaskDetailsArgs> {
  TaskDetails({
    _i16.Key? key,
    required _i18.TaskEntity task,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          TaskDetails.name,
          args: TaskDetailsArgs(
            key: key,
            task: task,
          ),
          initialChildren: children,
        );

  static const String name = 'TaskDetails';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TaskDetailsArgs>();
      return _i13.TaskDetails(
        key: args.key,
        task: args.task,
      );
    },
  );
}

class TaskDetailsArgs {
  const TaskDetailsArgs({
    this.key,
    required this.task,
  });

  final _i16.Key? key;

  final _i18.TaskEntity task;

  @override
  String toString() {
    return 'TaskDetailsArgs{key: $key, task: $task}';
  }
}

/// generated route for
/// [_i14.Tasks]
class Tasks extends _i15.PageRouteInfo<TasksArgs> {
  Tasks({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          Tasks.name,
          args: TasksArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Tasks';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TasksArgs>(orElse: () => const TasksArgs());
      return _i14.Tasks(key: args.key);
    },
  );
}

class TasksArgs {
  const TasksArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'TasksArgs{key: $key}';
  }
}
