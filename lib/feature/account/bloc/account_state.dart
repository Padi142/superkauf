import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'account_state.freezed.dart';

@freezed
abstract class AccountState with _$AccountState {
  const factory AccountState.loading() = Loading;

  const factory AccountState.loaded(UserModel user) = Loaded;

  const factory AccountState.error(String error) = Error;
}
