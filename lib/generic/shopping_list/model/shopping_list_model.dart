import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shopping_list_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ShoppingListModel extends Equatable {
  final int id;
  final String name;
  final int createdBy;
  final String logo;
  final String code;
  final DateTime createdAt;
  final int? postsLength;

  const ShoppingListModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.logo,
    required this.code,
    required this.createdAt,
    this.postsLength,
  });

  factory ShoppingListModel.fromJson(Map<String, dynamic> json) => _$ShoppingListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        createdBy,
        logo,
        createdAt,
      ];
}
