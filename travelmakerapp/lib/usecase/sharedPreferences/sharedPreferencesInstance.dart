import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesInstance {
  // Instância única (singleton)
  static final SharedPreferencesInstance _instance = SharedPreferencesInstance._internal();

  // SharedPreferences nullable, será preenchido no init()
  SharedPreferences? _preferences;

  // Construtor factory retorna sempre a mesma instância
  factory SharedPreferencesInstance() {
    return _instance;
  }

  // Construtor privado
  SharedPreferencesInstance._internal();

  // Método de inicialização (deve ser chamado 1x no início do app)
  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  // Getter seguro (lança exceção se init() não foi chamado)
  SharedPreferences get preferences {
    if (_preferences == null) {
      throw Exception(
          '[SharedPreferencesInstance] init() precisa ser chamado antes de acessar preferences.'
      );
    }
    return _preferences!;
  }
}
