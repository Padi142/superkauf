import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_shopping_list_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CreateShoppingListBody extends Equatable {
  final int createdBy;
  final String name;

  const CreateShoppingListBody({
    required this.createdBy,
    required this.name,
  });

  factory CreateShoppingListBody.fromJson(Map<String, dynamic> json) => _$CreateShoppingListBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateShoppingListBodyToJson(this);

  @override
  List<Object?> get props => [
        createdBy,
        name,
      ];
}
