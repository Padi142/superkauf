import 'package:equatable/equatable.dart';

sealed class NavigationState extends Equatable {
  const NavigationState();
}

class NavigationStateLoaded extends NavigationState {
  final int bottomNavIndex;
  final String screenName;
  final dynamic params;

  const NavigationStateLoaded({required this.bottomNavIndex, required this.screenName, this.params});

  @override
  List<Object?> get props => [bottomNavIndex];
}

class NavigationLoading extends NavigationState {
  const NavigationLoading();

  @override
  List<Object?> get props => [];
}
