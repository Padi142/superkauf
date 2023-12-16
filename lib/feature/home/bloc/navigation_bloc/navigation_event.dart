part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class OpenMyChannelScreen extends NavigationEvent {
  final int? index;

  const OpenMyChannelScreen(this.index);

  @override
  List<Object?> get props => [];
}

class OpenProfileScreen extends NavigationEvent {
  const OpenProfileScreen();

  @override
  List<Object?> get props => [];
}

class OpenFeedScreen extends NavigationEvent {
  final int? index;

  const OpenFeedScreen(this.index);

  @override
  List<Object?> get props => [];
}

class OpenDiscoverScreen extends NavigationEvent {
  final int? index;

  const OpenDiscoverScreen(this.index);

  @override
  List<Object?> get props => [];
}

class OpenShoppingListScreen extends NavigationEvent {
  final int? index;

  const OpenShoppingListScreen(this.index);

  @override
  List<Object?> get props => [];
}

class OpenStoresScreen extends NavigationEvent {
  final int? index;

  const OpenStoresScreen(this.index);

  @override
  List<Object?> get props => [];
}
