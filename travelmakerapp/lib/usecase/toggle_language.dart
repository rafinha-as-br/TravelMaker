import 'dart:ui';
import 'package:travelmakerapp/usecase/repositories/settings_repository.dart';
import 'package:travelmakerapp/entities/validator.dart';

Future<(Validator, Locale?)> toggleLocaleUseCase(
    SettingsRepository settingsRepo
    ) async {
  final supportedLocales = [
    const Locale('pt'),
    const Locale('en'),
    const Locale('es'),
  ];

  final savedLocaleStr = settingsRepo.getCurrentLocale();
  Locale currentLocale;

  if (savedLocaleStr.$1.success && savedLocaleStr.$2 != null) {
    currentLocale = savedLocaleStr.$2!;
  } else {
    currentLocale = const Locale('pt');
  }

  int currentIndex = supportedLocales.indexWhere(
        (locale) => locale.languageCode == currentLocale.languageCode,
  );

  int nextIndex = (currentIndex + 1) % supportedLocales.length;
  Locale newLocale = supportedLocales[nextIndex];

  final result = await settingsRepo.saveLocaleSharedPrefences(newLocale);

  if (!result.success) {
    return (result, null);
  }

  return (Validator(true, null), newLocale);
}
