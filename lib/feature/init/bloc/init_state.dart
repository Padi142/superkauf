import 'package:freezed_annotation/freezed_annotation.dart';

part 'init_state.freezed.dart';

@freezed
abstract class InitState with _$InitState {
  const factory InitState.loading() = Loading;
}
