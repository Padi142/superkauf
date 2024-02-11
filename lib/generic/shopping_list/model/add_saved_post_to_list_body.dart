import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_saved_post_to_list_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AddSavedPostToListBody extends Equatable {
  final int? savedPostId;
  final int listId;
  final int userId;
  final int? postId;

  const AddSavedPostToListBody({
    this.savedPostId,
    this.postId,
    required this.listId,
    required this.userId,
  });

  factory AddSavedPostToListBody.fromJson(Map<String, dynamic> json) => _$AddSavedPostToListBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddSavedPostToListBodyToJson(this);

  @override
  List<Object?> get props => [
        savedPostId,
        listId,
        userId,
      ];
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class RemoveSavedPostFromListBody extends Equatable {
  final int? savedPostId;
  final int listId;
  final int userId;
  final int? postId;

  const RemoveSavedPostFromListBody({
    this.savedPostId,
    this.postId,
    required this.listId,
    required this.userId,
  });

  factory RemoveSavedPostFromListBody.fromJson(Map<String, dynamic> json) => _$RemoveSavedPostFromListBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveSavedPostFromListBodyToJson(this);

  @override
  List<Object?> get props => [
        savedPostId,
        listId,
        userId,
      ];
}
