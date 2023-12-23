import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'snackbar_event.dart';
part 'snackbar_state.dart';

class SnackbarBloc extends Bloc<SnackBarEvent, SnackbarState> {
  SnackbarBloc() : super(const InitialSnackbarState()) {
    on<ErrorSnackbar>(_onErrorSnackbar);
    on<SuccessSnackbar>(_onSuccessSnackbar);
    on<InfoSnackbar>(_onInfoSnackbar);
  }

  Future<void> _onErrorSnackbar(
    ErrorSnackbar event,
    Emitter<SnackbarState> emit,
  ) async {
    emit(ErrorSnackbarState(message: event.message));
    await Future.delayed(const Duration(seconds: 3));
    emit(const InitialSnackbarState());
  }

  Future<void> _onSuccessSnackbar(
    SuccessSnackbar event,
    Emitter<SnackbarState> emit,
  ) async {
    emit(SuccessSnackbarState(message: event.message));
    await Future.delayed(const Duration(seconds: 3));
    emit(const InitialSnackbarState());
  }

  Future<void> _onInfoSnackbar(
    InfoSnackbar event,
    Emitter<SnackbarState> emit,
  ) async {
    emit(InfoSnackbarState(message: event.message));
    await Future.delayed(const Duration(seconds: 3));
    emit(const InitialSnackbarState());
  }
}
