import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shopping_list_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ShoppingListModel extends Equatable {
  final int id;
  final String name;
  final int createdBy;
  final String logo;
  final DateTime createdAt;

  const ShoppingListModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.logo,
    required this.createdAt,
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
