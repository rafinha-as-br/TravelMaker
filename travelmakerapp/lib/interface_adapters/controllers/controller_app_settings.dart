import 'package:flutter/material.dart';

import '../../entities/app_settings.dart';
import '../../entities/validator.dart';
import '../../usecase/toggle_language.dart';
import '../../usecase/toggle_theme.dart';
import '../implementations/implementation_settings_repository.dart';

/// controller that contains and controls an instance of AppSettings
class AppSettingsController {
  /// settings repository
  SettingsRepositoryImpl settingsRepo;

  /// theme mode var
  final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);

  /// locale var
  final locale = ValueNotifier<Locale>(Locale('en'));

  Locale _normalizeLocale(Locale deviceLocale) {
    const supported = ['pt', 'en', 'es'];
    if (supported.contains(deviceLocale.languageCode)) {
      return Locale(deviceLocale.languageCode);
    } else {
      return const Locale('en'); // fallback
    }
  }

  /// settings
  late final settings = ValueNotifier<AppSettings>(
    AppSettings(themeMode: themeMode.value, locale: locale.value),
  );

  Future<void> _loadInitialSettings() async {
    final themeResult = settingsRepo.getCurrentTheme();
    if (themeResult.$1.success && themeResult.$2 != null) {
      themeMode.value = themeResult.$2!;
    }

    final localeResult = settingsRepo.getCurrentLocale();
    if (localeResult.$1.success && localeResult.$2 != null) {
      locale.value = _normalizeLocale(localeResult.$2!);
    } else {
      locale.value = _normalizeLocale(
          WidgetsBinding.instance.platformDispatcher.locale);
    }

    _updateSettings();
  }

  ///
  AppSettingsController(this.settingsRepo) {
    themeMode.addListener(_updateSettings);
    locale.addListener(_updateSettings);

    _loadInitialSettings();
  }

  void _updateSettings() {
    final newSettings = AppSettings(
      themeMode: themeMode.value,
      locale: locale.value,
    );

    if (settings.value != newSettings) {
        settings.value = newSettings;
    }

  }

  /// set locale method
  void setLocale(Locale newLocale) {
    locale.value = _normalizeLocale(newLocale);
  }

  /// toggle theme method
  Future<Validator> toggleTheme() async{
    // call the useCse and receive to update themeMode.value from usecase

    final newTheme = await toggleThemeUseCase(settingsRepo);
    if(!newTheme.$1.success){
      return Validator(false, 'error on toggling the theme!');
    }
    themeMode.value = newTheme.$2!;
    return Validator(true, null);
  }

  /// toggle language method
  Future<Validator> toggleLanguage() async{
    final toggleLocale = await toggleLocaleUseCase(settingsRepo);
    if(!toggleLocale.$1.success){
      return Validator(false, 'error on toggling the language!');
    }

    locale.value = toggleLocale.$2!;
    return Validator(true, null);
  }

  /// method to start the settings on the loading of the app
  /// afterwards the appLoader will load the configs
  Future<Validator> initializeSettings() async {
    final themeResult = settingsRepo.getCurrentTheme();
    if (themeResult.$1.success && themeResult.$2 != null) {
      themeMode.value = themeResult.$2!;
    }

    final localeResult = settingsRepo.getCurrentLocale();
    if (localeResult.$1.success && localeResult.$2 != null) {
      locale.value = localeResult.$2!;
    }

    return Validator(true, null);
  }

}
