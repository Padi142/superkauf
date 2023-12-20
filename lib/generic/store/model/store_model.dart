import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class StoreModel extends Equatable {
  final int id;
  final String name;
  final String image;
  final DateTime createdAt;

  const StoreModel({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        createdAt,
      ];
}
