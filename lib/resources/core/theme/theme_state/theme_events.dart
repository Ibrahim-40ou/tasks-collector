part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  final bool isDarkMode;

  ChangeTheme({required this.isDarkMode});
}

class LoadTheme extends ThemeEvent {
  final bool isDarkMode;

  LoadTheme({required this.isDarkMode});
}
