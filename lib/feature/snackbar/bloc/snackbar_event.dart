part of 'snackbar_bloc.dart';

abstract class SnackBarEvent extends Equatable {
  const SnackBarEvent();

  @override
  List<Object> get props => [];
}

class ErrorSnackbar extends SnackBarEvent {
  final String message;

  const ErrorSnackbar({required this.message});
}

class SuccessSnackbar extends SnackBarEvent {
  final String message;

  const SuccessSnackbar({required this.message});
}

class InfoSnackbar extends SnackBarEvent {
  final String message;

  const InfoSnackbar({required this.message});
}
