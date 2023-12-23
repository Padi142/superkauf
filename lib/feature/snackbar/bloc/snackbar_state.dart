part of 'snackbar_bloc.dart';

abstract class SnackbarState extends Equatable {
  const SnackbarState();

  @override
  List<Object> get props => [];
}

class InitialSnackbarState extends SnackbarState {
  const InitialSnackbarState();
}

class ErrorSnackbarState extends SnackbarState {
  final String message;

  const ErrorSnackbarState({required this.message});
}

class SuccessSnackbarState extends SnackbarState {
  final String message;

  const SuccessSnackbarState({required this.message});
}

class InfoSnackbarState extends SnackbarState {
  final String message;

  const InfoSnackbarState({required this.message});
}
