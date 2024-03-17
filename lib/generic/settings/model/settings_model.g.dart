// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) => SettingsModel(
      country: CountryModel.fromJson(json['country'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) => <String, dynamic>{
      'country': instance.country.toJson(),
    };
