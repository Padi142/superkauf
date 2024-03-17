import 'package:superkauf/generic/settings/model/settings_model.dart';

import 'app_theme.dart';

class AppConfig {
  final String endpoint;
  final AppTheme theme;
  final SettingsModel settings;
  final List<String> languages;

  AppConfig({
    required this.endpoint,
    required this.theme,
    required this.settings,
    required this.languages,
  });
}
