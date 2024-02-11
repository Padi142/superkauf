import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_joined_result.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserJoinedResult extends Equatable {
  final int userId;
  final int shoppingListId;
  final String role;

  const UserJoinedResult({
    required this.userId,
    required this.shoppingListId,
    required this.role,
  });

  factory UserJoinedResult.fromJson(Map<String, dynamic> json) => _$UserJoinedResultFromJson(json);

  Map<String, dynamic> toJson() => _$UserJoinedResultToJson(this);

  @override
  List<Object?> get props => [
        userId,
        shoppingListId,
        role,
      ];
}
