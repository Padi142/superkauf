import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'saved_post_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SavedPostModel extends Equatable {
  final int id;
  final int post;
  final int user;
  final DateTime createdAt;

  const SavedPostModel({
    required this.id,
    required this.post,
    required this.user,
    required this.createdAt,
  });

  factory SavedPostModel.fromJson(Map<String, dynamic> json) => _$SavedPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$SavedPostModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        post,
        user,
        createdAt,
      ];
}
