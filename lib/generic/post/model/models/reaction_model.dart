import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ReactionModel extends Equatable {
  final int id;
  final int user;
  final int post;
  final String type;
  final DateTime createdAt;

  const ReactionModel({
    required this.id,
    required this.user,
    required this.post,
    required this.type,
    required this.createdAt,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json) => _$ReactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReactionModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        user,
        post,
        type,
        createdAt,
      ];
}
