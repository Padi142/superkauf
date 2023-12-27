import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PostModel extends Equatable {
  final int id;
  final String description;
  final int author;
  final double price;
  final String image;
  final String storeName;
  final int store;
  final int likes;
  final bool requiresStoreCard;
  final DateTime createdAt;

  const PostModel({
    required this.id,
    required this.description,
    required this.author,
    required this.price,
    required this.image,
    required this.storeName,
    required this.store,
    required this.likes,
    required this.requiresStoreCard,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        description,
        author,
        image,
        likes,
        storeName,
        createdAt,
      ];
}
