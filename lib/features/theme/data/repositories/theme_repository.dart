import '../datasource/theme_local_datasource.dart';

class ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepository(this.localDataSource);

  /// Get current theme mode
  Future<bool> getThemeMode() async {
    return await localDataSource.getThemeMode();
  }

  /// Save theme mode
  Future<void> saveThemeMode(bool isDark) async {
    await localDataSource.saveThemeMode(isDark);
  }

  /// Toggle theme mode
  Future<bool> toggleTheme() async {
    final isDark = await getThemeMode();

    final newTheme = !isDark;

    await saveThemeMode(newTheme);

    return newTheme;
  }
}
