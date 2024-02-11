import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'join_shopping_list_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class JoinShoppingListBody extends Equatable {
  final String code;
  final int userId;

  const JoinShoppingListBody({
    required this.code,
    required this.userId,
  });

  factory JoinShoppingListBody.fromJson(Map<String, dynamic> json) => _$JoinShoppingListBodyFromJson(json);

  Map<String, dynamic> toJson() => _$JoinShoppingListBodyToJson(this);

  @override
  List<Object?> get props => [
        code,
        userId,
      ];
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DeleteShoppingListBody extends Equatable {
  final int listId;
  final int userId;

  const DeleteShoppingListBody({
    required this.listId,
    required this.userId,
  });

  factory DeleteShoppingListBody.fromJson(Map<String, dynamic> json) => _$DeleteShoppingListBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteShoppingListBodyToJson(this);

  @override
  List<Object?> get props => [
        listId,
        userId,
      ];
}
