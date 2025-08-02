// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get welcome => 'Olá! Bem-vindo(a)!';

  @override
  String get beforeStart => 'Antes de começarmos';

  @override
  String get informNameAge => 'Nos diga seu nome e idade!';

  @override
  String get continuee => 'Continuar';

  @override
  String get goodMorning => 'Bom dia!';

  @override
  String get goodAfternon => 'Boa tarde!';

  @override
  String get goodNight => 'Boa noite';

  @override
  String get letsGoTravel => 'Vamos viajar?';

  @override
  String get createTravel => 'Criar uma viagem';

  @override
  String get travelList => 'Minhas viagens';

  @override
  String get userConfig => 'Usuário e configurações';

  @override
  String get changeLanguage => 'Mudar idioma';

  @override
  String get yourName => 'Seu nome';

  @override
  String get yourAge => 'Sua idade';

  @override
  String get yourNameError1 => 'Você precisa informar seu nome!';

  @override
  String get yourNameError2 => 'O nome precisa ter ao menos três letras';

  @override
  String get yourAgeError1 => 'Digite um número válido';

  @override
  String get yourAgeError2 => 'A idade não pode ser um número negativo!';

  @override
  String get yourAgeError3 => 'Você precisa informar sua idade!';

  @override
  String get addProfilePictureInform1 =>
      'Você pode adicionar uma foto de perfil a qualquer momento na seção de usuário!';

  @override
  String get lightTheme => 'Tema claro';

  @override
  String get darkTheme => 'Tema escuro';

  @override
  String get deleteUser => 'Excluir usuário';

  @override
  String get years => 'anos';
}
