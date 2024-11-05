part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeChanged extends ThemeState {
  final bool isDarkMode;

  ThemeChanged({required this.isDarkMode});
}
