import 'package:abm/resources/core/routing/routes.dart';
import 'package:abm/resources/core/routing/routes.gr.dart';
import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:abm/resources/core/theme/theme.dart';
import 'package:abm/resources/core/theme/theme_state/theme_bloc.dart';
import 'package:abm/resources/core/utils/common_functions.dart';
import 'package:abm/resources/core/widgets/image_viewer/state/cubit/image_viewer_cubit.dart';
import 'package:abm/resources/features/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:abm/resources/features/auth/presentation/state/cubit/timer_cubit.dart';
import 'package:abm/resources/features/tasks/presentation/state/bloc/tasks_bloc.dart';
import 'package:abm/resources/features/tasks/presentation/state/cubit/image_counter_cubit.dart';
import 'package:abm/resources/features/user_information/presentation/state/bloc/user_information_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

SharedPreferences? preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  preferences = await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://34d8892ffc138719b766dc0f49090bab@o4508278387376128.ingest.de.sentry.io/4508278390784080';
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'DZ'),
        ],
        path: 'assets/translations',
        saveLocale: true,
        startLocale: CommonFunctions().getStartingLanguage(),
        fallbackLocale: const Locale('en', 'US'),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ThemeBloc()
                ..add(
                  LoadTheme(
                    isDarkMode: preferences!.getString('theme') == 'dark'
                        ? true
                        : false,
                  ),
                ),
            ),
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(),
            ),
            BlocProvider(
              create: (context) {
                final userInformationBloc = UserInformationBloc();
                userInformationBloc.add(SerializationUserEvent());
                return userInformationBloc;
              },
            ),
            BlocProvider<TimerCubit>(
              create: (context) => TimerCubit(),
            ),
            BlocProvider<ImageViewerCubit>(
              create: (_) => ImageViewerCubit(0),
            ),
            BlocProvider<ImageCounterCubit>(
              create: (BuildContext context) => ImageCounterCubit(),
            ),
            BlocProvider<TasksBloc>(
              create: (BuildContext context) =>
                  TasksBloc()..add(SerializationEvent(isPagination: true)),
            ),
          ],
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isDarkMode = state is ThemeChanged
                ? state.isDarkMode
                : preferences?.getString('theme') == 'dark'
                    ? true
                    : false;
            CommonFunctions().initiateSystemThemes(isDarkMode);
            SizeConfig().init(constraints);
            return MaterialApp.router(
              title: 'ABM',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routerConfig: appRouter.config(
                deepLinkBuilder: (deepLink) {
                  if (deepLink.path
                      .startsWith('/app/tasksNavigator/details/')) {
                    if (preferences!.getBool('loggedIn') != true) {
                      preferences!
                          .setString('deepLink', deepLink.path.split('/').last);
                      return DeepLink.defaultPath;
                    } else {
                      DeepLink([App()]);
                      return deepLink;
                    }
                  } else {
                    return DeepLink.defaultPath;
                  }
                },
              ),
              theme: light,
              darkTheme: dark,
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  child: child!,
                );
              },
            );
          },
        );
      },
    );
  }
}

// print('hello world 2');
// final String id = deepLink.path
//     .substring('/app/tasksNavigator/details/'.length);
// final Result result = await TasksDatasource(httpsConsumer: HttpsConsumer())
//     .fetchTask(id);

//
// deepLinkBuilder: (deepLink) {
// print('hello 1');
// if (deepLink.path.startsWith('/app/settingsNavigator')) {
// print('hello 2');
// return deepLink;
// } else {
// print('hello 3');
// return DeepLink.defaultPath;
// }
// },
