import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/home/use_case/home_navigation.dart';

import 'home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeNavigation homeNavigation;
  HomeBloc({required this.homeNavigation}) : super(const HomeState.loading()) {
    on<HomeEvent>(_onInitEvent);
    on<GoToLogin>(_onGoToLogin);
  }
  Future<void> _onInitEvent(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {}
  Future<void> _onGoToLogin(
    GoToLogin event,
    Emitter<HomeState> emit,
  ) async {
    homeNavigation.goToLogin();
  }
}
