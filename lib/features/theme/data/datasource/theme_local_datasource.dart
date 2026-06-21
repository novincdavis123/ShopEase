import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:shopease/core/constants/app_constants.dart';

class ThemeLocalDataSource {
  Future<Box> _openBox() async {
    if (Hive.isBoxOpen(AppConstants.themeBoxName)) {
      return Hive.box(AppConstants.themeBoxName);
    }

    return await Hive.openBox(AppConstants.themeBoxName);
  }

  Future<bool> getThemeMode() async {
    final box = await _openBox();

    return box.get(AppConstants.themeKey, defaultValue: false) ?? false;
  }

  Future<void> saveThemeMode(bool isDark) async {
    final box = await _openBox();

    await box.put(AppConstants.themeKey, isDark);
  }
}
