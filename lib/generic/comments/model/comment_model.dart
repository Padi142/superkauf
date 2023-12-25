import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CommentModel extends Equatable {
  final int id;
  final String comment;
  final int user;
  final int post;
  final DateTime createdAt;

  const CommentModel({
    required this.id,
    required this.comment,
    required this.user,
    required this.post,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        comment,
        user,
        post,
        createdAt,
      ];
}
