// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcome => '¡Hola! ¡Bienvenido(a)!';

  @override
  String get beforeStart => 'Antes de comenzar';

  @override
  String get informNameAge => '¡Dinos tu nombre y edad!';

  @override
  String get continuee => 'Continuar';

  @override
  String get goodMorning => '¡Buenos días!';

  @override
  String get goodAfternon => '¡Buenas tardes!';

  @override
  String get goodNight => 'Buenas noches';

  @override
  String get letsGoTravel => '¿Vamos de viaje?';

  @override
  String get createTravel => 'Crear un viaje';

  @override
  String get travelList => 'Mis viajes';

  @override
  String get userConfig => 'Usuario y configuraciones';

  @override
  String get changeLanguage => 'Cambiar idioma';

  @override
  String get yourName => 'Tu nombre';

  @override
  String get yourAge => 'Tu edad';

  @override
  String get yourNameError1 => '¡Necesitas informar tu nombre!';

  @override
  String get yourNameError2 => 'El nombre debe tener al menos tres letras';

  @override
  String get yourAgeError1 => 'Escribe un número válido';

  @override
  String get yourAgeError2 => '¡La edad no puede ser un número negativo!';

  @override
  String get yourAgeError3 => '¡Necesitas informar tu edad!';

  @override
  String get addProfilePictureInform1 =>
      '¡Puedes agregar una foto de perfil en cualquier momento en la sección de usuario!';

  @override
  String get lightTheme => 'Tema claro';

  @override
  String get darkTheme => 'Tema oscuro';

  @override
  String get deleteUser => 'Eliminar usuario';

  @override
  String get years => 'años';
}
