import 'package:hive_ce_flutter/hive_flutter.dart';

class ThemeLocalDataSource {
  static const String boxName = 'theme_box';
  static const String themeKey = 'is_dark_mode';

  Future<Box> _openBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    }

    return await Hive.openBox(boxName);
  }

  Future<bool> getThemeMode() async {
    final box = await _openBox();

    return box.get(themeKey, defaultValue: false) ?? false;
  }

  Future<void> saveThemeMode(bool isDark) async {
    final box = await _openBox();

    await box.put(themeKey, isDark);
  }
}
