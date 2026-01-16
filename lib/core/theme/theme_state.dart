part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {

}

final class ThemeInitial extends ThemeState {
  final ThemeMode themeMode;

  ThemeInitial({required this.themeMode});
}
