import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:superkauf/generic/countries/model/country_model.dart';

part 'settings_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SettingsModel extends Equatable {
  final CountryModel country;

  const SettingsModel({
    required this.country,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);

  @override
  List<Object?> get props => [
        country,
      ];

  SettingsModel copyWith({
    CountryModel? country,
  }) {
    return SettingsModel(
      country: country ?? this.country,
    );
  }
}
