part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class Initial extends HomeEvent {
  const Initial();
}

class GoToLogin extends HomeEvent {
  const GoToLogin();
}
