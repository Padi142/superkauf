import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_reaction_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AddReactionModel extends Equatable {
  final int user;
  final int post;
  final String type;

  const AddReactionModel({
    required this.user,
    required this.post,
    required this.type,
  });

  factory AddReactionModel.fromJson(Map<String, dynamic> json) => _$AddReactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddReactionModelToJson(this);

  @override
  List<Object?> get props => [
        user,
        post,
        type,
      ];
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class RemoveReactionModel extends Equatable {
  final int user;
  final int post;
  final String type;

  const RemoveReactionModel({
    required this.user,
    required this.post,
    required this.type,
  });

  factory RemoveReactionModel.fromJson(Map<String, dynamic> json) => _$RemoveReactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveReactionModelToJson(this);

  @override
  List<Object?> get props => [
        user,
        post,
        type,
      ];
}
