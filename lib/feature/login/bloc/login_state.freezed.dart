// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() loginInProgress,
    required TResult Function() confirmEmail,
    required TResult Function(String username) loggedIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? loginInProgress,
    TResult? Function()? confirmEmail,
    TResult? Function(String username)? loggedIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? loginInProgress,
    TResult Function()? confirmEmail,
    TResult Function(String username)? loggedIn,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
    required TResult Function(LoginInProgress value) loginInProgress,
    required TResult Function(ConfirmEmail value) confirmEmail,
    required TResult Function(LoggedIn value) loggedIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
    TResult? Function(LoginInProgress value)? loginInProgress,
    TResult? Function(ConfirmEmail value)? confirmEmail,
    TResult? Function(LoggedIn value)? loggedIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(LoginInProgress value)? loginInProgress,
    TResult Function(ConfirmEmail value)? confirmEmail,
    TResult Function(LoggedIn value)? loggedIn,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) then) = _$LoginStateCopyWithImpl<$Res, LoginState>;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState> implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(_$LoadingImpl value, $Res Function(_$LoadingImpl) then) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res, _$LoadingImpl> implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(_$LoadingImpl _value, $Res Function(_$LoadingImpl) _then) : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'LoginState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() loginInProgress,
    required TResult Function() confirmEmail,
    required TResult Function(String username) loggedIn,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? loginInProgress,
    TResult? Function()? confirmEmail,
    TResult? Function(String username)? loggedIn,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? loginInProgress,
    TResult Function()? confirmEmail,
    TResult Function(String username)? loggedIn,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
    required TResult Function(LoginInProgress value) loginInProgress,
    required TResult Function(ConfirmEmail value) confirmEmail,
    required TResult Function(LoggedIn value) loggedIn,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
    TResult? Function(LoginInProgress value)? loginInProgress,
    TResult? Function(ConfirmEmail value)? confirmEmail,
    TResult? Function(LoggedIn value)? loggedIn,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(LoginInProgress value)? loginInProgress,
    TResult Function(ConfirmEmail value)? confirmEmail,
    TResult Function(LoggedIn value)? loggedIn,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements LoginState {
  const factory Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(_$ErrorImpl value, $Res Function(_$ErrorImpl) then) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res, _$ErrorImpl> implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(_$ErrorImpl _value, $Res Function(_$ErrorImpl) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'LoginState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$ErrorImpl && (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith => __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() loginInProgress,
    required TResult Function() confirmEmail,
    required TResult Function(String username) loggedIn,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? loginInProgress,
    TResult? Function()? confirmEmail,
    TResult? Function(String username)? loggedIn,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? loginInProgress,
    TResult Function()? confirmEmail,
    TResult Function(String username)? loggedIn,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
    required TResult Function(LoginInProgress value) loginInProgress,
    required TResult Function(ConfirmEmail value) confirmEmail,
    required TResult Function(LoggedIn value) loggedIn,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
    TResult? Function(LoginInProgress value)? loginInProgress,
    TResult? Function(ConfirmEmail value)? confirmEmail,
    TResult? Function(LoggedIn value)? loggedIn,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(LoginInProgress value)? loginInProgress,
    TResult Function(ConfirmEmail value)? confirmEmail,
    TResult Function(LoggedIn value)? loggedIn,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements LoginState {
  const factory Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginInProgressImplCopyWith<$Res> {
  factory _$$LoginInProgressImplCopyWith(_$LoginInProgressImpl value, $Res Function(_$LoginInProgressImpl) then) = __$$LoginInProgressImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginInProgressImplCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res, _$LoginInProgressImpl> implements _$$LoginInProgressImplCopyWith<$Res> {
  __$$LoginInProgressImplCopyWithImpl(_$LoginInProgressImpl _value, $Res Function(_$LoginInProgressImpl) _then) : super(_value, _then);
}

/// @nodoc

class _$LoginInProgressImpl implements LoginInProgress {
  const _$LoginInProgressImpl();

  @override
  String toString() {
    return 'LoginState.loginInProgress()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$LoginInProgressImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() loginInProgress,
    required TResult Function() confirmEmail,
    required TResult Function(String username) loggedIn,
  }) {
    return loginInProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? loginInProgress,
    TResult? Function()? confirmEmail,
    TResult? Function(String username)? loggedIn,
  }) {
    return loginInProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? loginInProgress,
    TResult Function()? confirmEmail,
    TResult Function(String username)? loggedIn,
    required TResult orElse(),
  }) {
    if (loginInProgress != null) {
      return loginInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
    required TResult Function(LoginInProgress value) loginInProgress,
    required TResult Function(ConfirmEmail value) confirmEmail,
    required TResult Function(LoggedIn value) loggedIn,
  }) {
    return loginInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
    TResult? Function(LoginInProgress value)? loginInProgress,
    TResult? Function(ConfirmEmail value)? confirmEmail,
    TResult? Function(LoggedIn value)? loggedIn,
  }) {
    return loginInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(LoginInProgress value)? loginInProgress,
    TResult Function(ConfirmEmail value)? confirmEmail,
    TResult Function(LoggedIn value)? loggedIn,
    required TResult orElse(),
  }) {
    if (loginInProgress != null) {
      return loginInProgress(this);
    }
    return orElse();
  }
}

abstract class LoginInProgress implements LoginState {
  const factory LoginInProgress() = _$LoginInProgressImpl;
}

/// @nodoc
abstract class _$$ConfirmEmailImplCopyWith<$Res> {
  factory _$$ConfirmEmailImplCopyWith(_$ConfirmEmailImpl value, $Res Function(_$ConfirmEmailImpl) then) = __$$ConfirmEmailImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConfirmEmailImplCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res, _$ConfirmEmailImpl> implements _$$ConfirmEmailImplCopyWith<$Res> {
  __$$ConfirmEmailImplCopyWithImpl(_$ConfirmEmailImpl _value, $Res Function(_$ConfirmEmailImpl) _then) : super(_value, _then);
}

/// @nodoc

class _$ConfirmEmailImpl implements ConfirmEmail {
  const _$ConfirmEmailImpl();

  @override
  String toString() {
    return 'LoginState.confirmEmail()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$ConfirmEmailImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() loginInProgress,
    required TResult Function() confirmEmail,
    required TResult Function(String username) loggedIn,
  }) {
    return confirmEmail();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? loginInProgress,
    TResult? Function()? confirmEmail,
    TResult? Function(String username)? loggedIn,
  }) {
    return confirmEmail?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? loginInProgress,
    TResult Function()? confirmEmail,
    TResult Function(String username)? loggedIn,
    required TResult orElse(),
  }) {
    if (confirmEmail != null) {
      return confirmEmail();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
    required TResult Function(LoginInProgress value) loginInProgress,
    required TResult Function(ConfirmEmail value) confirmEmail,
    required TResult Function(LoggedIn value) loggedIn,
  }) {
    return confirmEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
    TResult? Function(LoginInProgress value)? loginInProgress,
    TResult? Function(ConfirmEmail value)? confirmEmail,
    TResult? Function(LoggedIn value)? loggedIn,
  }) {
    return confirmEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(LoginInProgress value)? loginInProgress,
    TResult Function(ConfirmEmail value)? confirmEmail,
    TResult Function(LoggedIn value)? loggedIn,
    required TResult orElse(),
  }) {
    if (confirmEmail != null) {
      return confirmEmail(this);
    }
    return orElse();
  }
}

abstract class ConfirmEmail implements LoginState {
  const factory ConfirmEmail() = _$ConfirmEmailImpl;
}

/// @nodoc
abstract class _$$LoggedInImplCopyWith<$Res> {
  factory _$$LoggedInImplCopyWith(_$LoggedInImpl value, $Res Function(_$LoggedInImpl) then) = __$$LoggedInImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String username});
}

/// @nodoc
class __$$LoggedInImplCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res, _$LoggedInImpl> implements _$$LoggedInImplCopyWith<$Res> {
  __$$LoggedInImplCopyWithImpl(_$LoggedInImpl _value, $Res Function(_$LoggedInImpl) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
  }) {
    return _then(_$LoggedInImpl(
      null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoggedInImpl implements LoggedIn {
  const _$LoggedInImpl(this.username);

  @override
  final String username;

  @override
  String toString() {
    return 'LoginState.loggedIn(username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$LoggedInImpl && (identical(other.username, username) || other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoggedInImplCopyWith<_$LoggedInImpl> get copyWith => __$$LoggedInImplCopyWithImpl<_$LoggedInImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function() loginInProgress,
    required TResult Function() confirmEmail,
    required TResult Function(String username) loggedIn,
  }) {
    return loggedIn(username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function()? loginInProgress,
    TResult? Function()? confirmEmail,
    TResult? Function(String username)? loggedIn,
  }) {
    return loggedIn?.call(username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function()? loginInProgress,
    TResult Function()? confirmEmail,
    TResult Function(String username)? loggedIn,
    required TResult orElse(),
  }) {
    if (loggedIn != null) {
      return loggedIn(username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
    required TResult Function(LoginInProgress value) loginInProgress,
    required TResult Function(ConfirmEmail value) confirmEmail,
    required TResult Function(LoggedIn value) loggedIn,
  }) {
    return loggedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
    TResult? Function(LoginInProgress value)? loginInProgress,
    TResult? Function(ConfirmEmail value)? confirmEmail,
    TResult? Function(LoggedIn value)? loggedIn,
  }) {
    return loggedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(LoginInProgress value)? loginInProgress,
    TResult Function(ConfirmEmail value)? confirmEmail,
    TResult Function(LoggedIn value)? loggedIn,
    required TResult orElse(),
  }) {
    if (loggedIn != null) {
      return loggedIn(this);
    }
    return orElse();
  }
}

abstract class LoggedIn implements LoginState {
  const factory LoggedIn(final String username) = _$LoggedInImpl;

  String get username;
  @JsonKey(ignore: true)
  _$$LoggedInImplCopyWith<_$LoggedInImpl> get copyWith => throw _privateConstructorUsedError;
}
