import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/settings/model/settings_model.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState.loading() = Loading;

  const factory SettingsState.loaded(SettingsModel settings) = Loaded;

  const factory SettingsState.error(String error) = Error;
}
