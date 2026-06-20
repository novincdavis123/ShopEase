import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/theme_repository.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeRepository repository;

  ThemeCubit(this.repository) : super(const ThemeState(isDark: false));

  /// Load saved theme from Hive CE
  Future<void> loadTheme() async {
    final isDark = await repository.getThemeMode();

    emit(ThemeState(isDark: isDark));
  }

  /// Toggle between light and dark mode
  Future<void> toggleTheme() async {
    final newTheme = await repository.toggleTheme();

    emit(ThemeState(isDark: newTheme));
  }

  /// Explicitly set theme
  Future<void> setTheme(bool isDark) async {
    await repository.saveThemeMode(isDark);

    emit(ThemeState(isDark: isDark));
  }
}
