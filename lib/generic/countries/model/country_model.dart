import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CountryModel extends Equatable {
  final String code;
  final String name;
  final String currency;

  const CountryModel({
    required this.code,
    required this.currency,
    required this.name,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  @override
  List<Object?> get props => [
        code,
        name,
        currency,
      ];
}
