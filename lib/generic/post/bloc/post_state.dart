import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_state.freezed.dart';

@freezed
abstract class PostState with _$PostState {
  const factory PostState.loading() = Loading;

  const factory PostState.success() = Success;

  const factory PostState.error(String error) = Error;
}
