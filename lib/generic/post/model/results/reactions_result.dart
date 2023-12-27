import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/models/reaction_model.dart';

part 'reactions_result.freezed.dart';

@freezed
class ReactionsResult with _$ReactionsResult {
  const factory ReactionsResult.success(ReactionModel reaction) = Success;

  const factory ReactionsResult.failure(String message) = Failure;
}
