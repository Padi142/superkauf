import 'package:easy_localization/easy_localization.dart';

import '../../library/app_config.dart';
import '../../library/app_navigation.dart';

class LocaleResource {
  final AppConfig appConfig;

  LocaleResource({
    required this.appConfig,
  });

  Future<String> load() async {
    return AppNavigation().navigationKey.currentContext?.locale.toString() ?? (appConfig.languages.isEmpty ? '' : appConfig.languages.first);
  }
}
