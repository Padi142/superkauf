import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_post_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SearchPostModel extends Equatable {
  final int id;
  final String description;
  final String storeName;
  final String image;
  final double? price;
  final int? author;

  const SearchPostModel({
    required this.id,
    required this.description,
    required this.storeName,
    required this.image,
    this.price,
    this.author,
  });

  factory SearchPostModel.fromJson(Map<String, dynamic> json) => _$SearchPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPostModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        description,
        storeName,
        image,
      ];
}
