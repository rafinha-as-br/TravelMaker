import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/interface_adapters/implementations/implementation_settings_repository.dart';
import 'package:travelmakerapp/usecase/toggle_language.dart';
import 'package:travelmakerapp/usecase/toggle_theme.dart';
import '../../entities/appSettings.dart';

class AppSettingsController {
  SettingsRepositoryImpl settingsRepo;


  final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);

  final locale = ValueNotifier<Locale>(Locale('en'));

  Locale _normalizeLocale(Locale deviceLocale) {
    const supported = ['pt', 'en', 'es'];
    if (supported.contains(deviceLocale.languageCode)) {
      return Locale(deviceLocale.languageCode);
    } else {
      return const Locale('en'); // fallback
    }
  }



  late final settings = ValueNotifier<AppSettings>(
    AppSettings(themeMode: themeMode.value, locale: locale.value),
  );

  Future<void> _loadInitialSettings() async {
    final themeResult = await settingsRepo.getCurrentTheme();
    if (themeResult.$1.success && themeResult.$2 != null) {
      themeMode.value = themeResult.$2!;
    }

    final localeResult = await settingsRepo.getCurrentLocale();
    if (localeResult.$1.success && localeResult.$2 != null) {
      locale.value = _normalizeLocale(localeResult.$2!);
    } else {
      locale.value = _normalizeLocale(
          WidgetsBinding.instance.platformDispatcher.locale);
    }

    _updateSettings();
  }


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


  void setLocale(Locale newLocale) {
    locale.value = _normalizeLocale(newLocale);
  }

  Future<Validator> toggleTheme() async{
    // call the useCse and receive to update themeMode.value from usecase

    final newTheme = await toggleThemeUseCase(settingsRepo);
    if(!newTheme.$1.success){
      return Validator(false, 'error on toggling the theme!');
    }
    themeMode.value = newTheme.$2!;
    return Validator(true, null);
  }

  Future<Validator> toggleLanguage() async{
    final toggleLocale = await toggleLocaleUseCase(settingsRepo);
    if(!toggleLocale.$1.success){
      return Validator(false, 'error on toggling the language!');
    }

    locale.value = toggleLocale.$2!;
    return Validator(true, null);
  }

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
