import 'package:flutter/material.dart';
import 'package:travelmakerapp/entities/validator.dart';
import 'package:travelmakerapp/interface_adapters/implementations/settings_repository.dart';
import 'package:travelmakerapp/usecase/toggle_theme.dart';
import '../../entities/appSettings.dart';

class AppSettingsController {
  SettingsRepositoryImpl settingsRepo;
  final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);

  final locale = ValueNotifier<Locale>(
    WidgetsBinding.instance.platformDispatcher.locale,
  );

  late final settings = ValueNotifier<AppSettings>(
    AppSettings(themeMode: themeMode.value, locale: locale.value),
  );

  AppSettingsController(
      this.settingsRepo
      )
  {
    themeMode.addListener(_updateSettings);
    locale.addListener(_updateSettings);
  }

  void _updateSettings() {
    settings.value = AppSettings(themeMode: themeMode.value, locale: locale.value);
  }


  void setLocale(Locale newLocale) {
    locale.value = newLocale;
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
    final toggleLocale = await toggleThemeUseCase(settingsRepo);
    if(!toggleLocale.$1.success){
      return Validator(false, 'error on toggling the language!');
    }


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
