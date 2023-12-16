import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PostModel extends Equatable {
  final int id;
  final String description;
  final int author;
  final String image;
  final String storeName;
  final DateTime createdAt;

  const PostModel({
    required this.id,
    required this.description,
    required this.author,
    required this.image,
    required this.storeName,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        description,
        author,
        image,
        storeName,
        createdAt,
      ];
}
