import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../use_case/init_navigation.dart';
import 'init_state.dart';

part 'init_event.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  InitNavigation initNavigation;

  InitBloc({
    required this.initNavigation,
  }) : super(const InitState.loading()) {
    on<InitApplication>(_onInitApplication);
  }
  Future<void> _onInitApplication(
    InitApplication event,
    Emitter<InitState> emit,
  ) async {
    emit(const InitState.loading());
    initNavigation.goToHome();
  }
}
