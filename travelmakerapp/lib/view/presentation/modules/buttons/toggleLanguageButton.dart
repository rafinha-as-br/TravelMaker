import 'package:flutter/material.dart';
import 'package:travelmakerapp/l10n/app_localizations.dart';
import 'package:travelmakerapp/view/presentation/helpers/getFlag.dart';

import '../../../../interface_adapters/controllers/appSettingsController.dart';
import '../dialogs/errorDialog.dart';


// expanded toggleLanguageButton, (with text and flag), used in userConfigScreen
class ToggleLanguageButtonExpanded extends StatelessWidget {
  final AppSettingsController settingsController;

  const ToggleLanguageButtonExpanded({super.key, required this.settingsController});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: settingsController.locale,
      builder: (context, locale, child) {
        return InkWell(
          onTap: () async {
            final toggleLanguage = await settingsController.toggleLanguage();
            if (!toggleLanguage.success && context.mounted) {
              await showDialog(
                context: context,
                builder: (context) => ErrorDialog(textError: toggleLanguage.message!),
              );
            }
          },
          child: Container(
            width: 180,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              border: Border.all(
                width: 1.5,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                getFlag(locale.toString()), // usa o locale atualizado
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context)!.changeLanguage,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// reduced toggleLanguageButton (only with flag), used in startScreen
class ToggleLanguageButtonReduced extends StatelessWidget {
  final AppSettingsController settingsController;
  const ToggleLanguageButtonReduced({super.key, required this.settingsController});

  @override
  Widget build(BuildContext context) {
    print("settingsController locale =>>>> ${settingsController.locale.value.toString()}");

    return ValueListenableBuilder<Locale>(
      valueListenable: settingsController.locale,
      builder: (context, locale, child) {
        return InkWell(
          onTap: () async {
            final toggleLanguage = await settingsController.toggleLanguage();
            if (!toggleLanguage.success && context.mounted) {
              await showDialog(
                context: context,
                builder: (context) => ErrorDialog(textError: toggleLanguage.message!),
              );
            }
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              border: Border.all(
                width: 1.5,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: getFlag(locale.toString()),
          ),
        );
      },
    );
  }
}

