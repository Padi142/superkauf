import 'package:equatable/equatable.dart';

sealed class NavigationState extends Equatable {
  const NavigationState();
}

class NavigationStateLoaded extends NavigationState {
  final int bottomNavIndex;
  final String screenName;

  const NavigationStateLoaded({required this.bottomNavIndex, required this.screenName});

  @override
  List<Object?> get props => [bottomNavIndex];
}
