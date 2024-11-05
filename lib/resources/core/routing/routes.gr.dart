// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:abm/resources/core/routing/pages/app.dart' as _i2;
import 'package:abm/resources/core/routing/pages/initial_route.dart' as _i6;
import 'package:abm/resources/core/widgets/image_viewer/widget/image_viewer.dart'
    as _i5;
import 'package:abm/resources/features/auth/presentation/pages/landing.dart'
    as _i7;
import 'package:abm/resources/features/auth/presentation/pages/login.dart'
    as _i8;
import 'package:abm/resources/features/auth/presentation/pages/otp.dart'
    as _i10;
import 'package:abm/resources/features/auth/presentation/pages/register.dart'
    as _i12;
import 'package:abm/resources/features/complaints/domain/entities/complaint_entity.dart'
    as _i17;
import 'package:abm/resources/features/complaints/presentation/pages/add_complaint.dart'
    as _i1;
import 'package:abm/resources/features/complaints/presentation/pages/complaint_details.dart'
    as _i3;
import 'package:abm/resources/features/complaints/presentation/pages/complaints.dart'
    as _i4;
import 'package:abm/resources/features/notifications/presentation/pages/notifications.dart'
    as _i9;
import 'package:abm/resources/features/statistics/presentation/pages/statistics.dart'
    as _i14;
import 'package:abm/resources/features/user_information/presentation/pages/profile.dart'
    as _i11;
import 'package:abm/resources/features/user_information/presentation/pages/settings.dart'
    as _i13;
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/cupertino.dart' as _i18;
import 'package:flutter/material.dart' as _i16;

/// generated route for
/// [_i1.AddComplaintPage]
class AddComplaintRoute extends _i15.PageRouteInfo<AddComplaintRouteArgs> {
  AddComplaintRoute({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          AddComplaintRoute.name,
          args: AddComplaintRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AddComplaintRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddComplaintRouteArgs>(
          orElse: () => const AddComplaintRouteArgs());
      return _i1.AddComplaintPage(key: args.key);
    },
  );
}

class AddComplaintRouteArgs {
  const AddComplaintRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'AddComplaintRouteArgs{key: $key}';
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
/// [_i3.ComplaintDetails]
class ComplaintDetails extends _i15.PageRouteInfo<ComplaintDetailsArgs> {
  ComplaintDetails({
    _i16.Key? key,
    required _i17.ComplaintEntity complaint,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ComplaintDetails.name,
          args: ComplaintDetailsArgs(
            key: key,
            complaint: complaint,
          ),
          initialChildren: children,
        );

  static const String name = 'ComplaintDetails';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ComplaintDetailsArgs>();
      return _i3.ComplaintDetails(
        key: args.key,
        complaint: args.complaint,
      );
    },
  );
}

class ComplaintDetailsArgs {
  const ComplaintDetailsArgs({
    this.key,
    required this.complaint,
  });

  final _i16.Key? key;

  final _i17.ComplaintEntity complaint;

  @override
  String toString() {
    return 'ComplaintDetailsArgs{key: $key, complaint: $complaint}';
  }
}

/// generated route for
/// [_i4.Complaints]
class Complaints extends _i15.PageRouteInfo<void> {
  const Complaints({List<_i15.PageRouteInfo>? children})
      : super(
          Complaints.name,
          initialChildren: children,
        );

  static const String name = 'Complaints';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return _i4.Complaints();
    },
  );
}

/// generated route for
/// [_i5.ImageViewer]
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
      return _i5.ImageViewer(
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
/// [_i6.InitialScreen]
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
      return const _i6.InitialScreen();
    },
  );
}

/// generated route for
/// [_i7.Landing]
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
      return const _i7.Landing();
    },
  );
}

/// generated route for
/// [_i8.Login]
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
      return _i8.Login(key: args.key);
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
/// [_i9.Notifications]
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
      return _i9.Notifications(key: args.key);
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
/// [_i10.OTP]
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
      return _i10.OTP(
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
/// [_i11.ProfileInformation]
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
      return _i11.ProfileInformation(key: args.key);
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
/// [_i12.Register]
class Register extends _i15.PageRouteInfo<RegisterArgs> {
  Register({
    _i18.Key? key,
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
      return _i12.Register(key: args.key);
    },
  );
}

class RegisterArgs {
  const RegisterArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'RegisterArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.Settings]
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
      return const _i13.Settings();
    },
  );
}

/// generated route for
/// [_i14.Statistics]
class Statistics extends _i15.PageRouteInfo<void> {
  const Statistics({List<_i15.PageRouteInfo>? children})
      : super(
          Statistics.name,
          initialChildren: children,
        );

  static const String name = 'Statistics';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return _i14.Statistics();
    },
  );
}
