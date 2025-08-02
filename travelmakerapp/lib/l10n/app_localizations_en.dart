// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Hello! Welcome!';

  @override
  String get beforeStart => 'Before we start';

  @override
  String get informNameAge => 'Tell us your name and age!';

  @override
  String get continuee => 'Continue';

  @override
  String get goodMorning => 'Good morning!';

  @override
  String get goodAfternon => 'Good afternoon!';

  @override
  String get goodNight => 'Good Night';

  @override
  String get letsGoTravel => 'Let\'s go travel?';

  @override
  String get createTravel => 'Make a travel';

  @override
  String get travelList => 'My trips';

  @override
  String get userConfig => 'User & configurations';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get yourName => 'Your name';

  @override
  String get yourAge => 'Your age';

  @override
  String get yourNameError1 => 'You need to inform your name!';

  @override
  String get yourNameError2 =>
      'The name needs to contains at least three letters';

  @override
  String get yourAgeError1 => 'Type a valid number';

  @override
  String get yourAgeError2 => 'The age can\'t be a negative number!';

  @override
  String get yourAgeError3 => 'You need to inform your age!';

  @override
  String get addProfilePictureInform1 =>
      'You can add a profile picture anytime in the user section!';

  @override
  String get lightTheme => 'Light theme';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get deleteUser => 'Delete user';

  @override
  String get years => 'years';
}
