import 'package:abm/resources/core/routing/routes.dart';
import 'package:abm/resources/core/sizing/size_config.dart';
import 'package:abm/resources/core/theme/theme.dart';
import 'package:abm/resources/core/theme/theme_state/theme_bloc.dart';
import 'package:abm/resources/core/utils/common_functions.dart';
import 'package:abm/resources/core/widgets/image_viewer/state/cubit/image_viewer_cubit.dart';
import 'package:abm/resources/features/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:abm/resources/features/auth/presentation/state/cubit/timer_cubit.dart';
import 'package:abm/resources/features/complaints/presentation/state/cubit/image_counter_cubit.dart';
import 'package:abm/resources/features/user_information/presentation/state/bloc/user_information_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  preferences = await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
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
                  isDarkMode:
                      preferences!.getString('theme') == 'dark' ? true : false,
                ),
              ),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          BlocProvider<UserInformationBloc>(
            create: (context) => UserInformationBloc()
              ..add(
                UpdateUserInformation(
                  fullName: preferences!.getString('name') ?? '',
                  avatar: preferences!.getString('avatar') ?? '',
                  governorate: preferences!.getString('governorate_id') ?? '',
                  phoneNumber: preferences!.getString('phone_number') ?? '',
                ),
              )
              ..add(
                FetchCurrentUserInformation(),
              ),
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
        ],
        child: MyApp(),
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
              title: 'Tasks Collector',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routerConfig: appRouter.config(),
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
