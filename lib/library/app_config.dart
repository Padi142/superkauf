import 'app_theme.dart';

class AppConfig {
  final String endpoint;
  final AppTheme theme;
  final List<String> languages;

  AppConfig({
    required this.endpoint,
    required this.theme,
    required this.languages,
  });
}
