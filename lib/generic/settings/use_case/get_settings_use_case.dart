import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:superkauf/generic/settings/model/settings_model.dart';
import 'package:superkauf/library/use_case.dart';

class GetSettingsUseCase extends UnitUseCase<SettingsModel> {
  GetSettingsUseCase();

  @override
  Future<SettingsModel> call() async {
    final box = await Hive.openBox('settings');

    if (box.isNotEmpty) {
      try {
        return SettingsModel.fromJson(json.decode(await box.get('settings')) as Map<String, dynamic>);
      } catch (e) {
        print(e);
      }
    }

    const defaultSettings = SettingsModel(country: 'cs');

    await box.put('settings', json.encode(defaultSettings.toJson()));

    return defaultSettings;
  }
}
