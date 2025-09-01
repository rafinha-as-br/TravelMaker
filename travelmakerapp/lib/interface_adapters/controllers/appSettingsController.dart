import 'package:flutter/material.dart';


class AppSettings {
  final ThemeMode themeMode;
  final Locale locale;

  AppSettings({required this.themeMode, required this.locale});
}


class AppSettingsController {
  final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);

  final locale = ValueNotifier<Locale>(
    WidgetsBinding.instance.platformDispatcher.locale,
  );

  late final settings = ValueNotifier<AppSettings>(
    AppSettings(themeMode: themeMode.value, locale: locale.value),
  );

  AppSettingsController() {
    themeMode.addListener(_updateSettings);
    locale.addListener(_updateSettings);
  }

  void _updateSettings() {
    settings.value = AppSettings(themeMode: themeMode.value, locale: locale.value);
  }

  void toggleTheme() {
    final isDark = themeMode.value == ThemeMode.dark;
    themeMode.value = isDark ? ThemeMode.light : ThemeMode.dark;
  }

  void setLocale(Locale newLocale) {
    locale.value = newLocale;
  }
}
