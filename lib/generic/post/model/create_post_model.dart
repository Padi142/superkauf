import 'package:json_annotation/json_annotation.dart';

part 'create_post_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CreatePostModel {
  final String description;
  final double price;
  final String author;
  final String storeName;
  final int store;
  final DateTime? validUntil;
  final bool requiresStoreCard;

  const CreatePostModel({
    required this.description,
    required this.price,
    required this.author,
    required this.storeName,
    required this.store,
    required this.validUntil,
    required this.requiresStoreCard,
  });

  factory CreatePostModel.fromJson(Map<String, dynamic> json) => _$CreatePostModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostModelToJson(this);
}
