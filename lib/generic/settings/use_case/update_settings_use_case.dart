import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:superkauf/generic/settings/model/settings_model.dart';
import 'package:superkauf/library/use_case.dart';

class UpdateSettingsUseCase extends UseCase<SettingsModel, SettingsModel> {
  UpdateSettingsUseCase();

  @override
  Future<SettingsModel> call(params) async {
    final box = await Hive.openBox('settings');

    await box.put('settings', json.encode(params.toJson()));

    return params;
  }
}
