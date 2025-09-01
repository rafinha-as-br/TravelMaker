import 'package:travelmakerapp/entities/appSettings.dart';

abstract class SettingsRepository{
  Future<void> saveSettingsSharedPreferences(AppSettings settings);
  Future<void> removeSettingsSharedPreferences(AppSettings settings);
}