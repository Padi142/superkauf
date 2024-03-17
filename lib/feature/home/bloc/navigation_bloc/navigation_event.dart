part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class OpenSettingsScreen extends NavigationEvent {
  final bool shouldReplace;
  const OpenSettingsScreen({
    this.shouldReplace = false,
  });

  @override
  List<Object?> get props => [];
}

class OpenProfileScreen extends NavigationEvent {
  final bool shouldReplace;

  const OpenProfileScreen({this.shouldReplace = false});

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
  final int? storeId;

  const OpenStoresScreen(this.index, {this.storeId});

  @override
  List<Object?> get props => [];
}

class GoToCreatePostScreen extends NavigationEvent {
  final int? index;

  const GoToCreatePostScreen(
    this.index,
  );

  @override
  List<Object?> get props => [];
}

class OpenSearchScreen extends NavigationEvent {
  final int? index;

  const OpenSearchScreen(
    this.index,
  );

  @override
  List<Object?> get props => [];
}

class OpenPostDetailScreen extends NavigationEvent {
  final int postId;

  const OpenPostDetailScreen({
    required this.postId,
  });

  @override
  List<Object?> get props => [];
}

class OpenUserDetailScreen extends NavigationEvent {
  const OpenUserDetailScreen();

  @override
  List<Object?> get props => [];
}

class OpenMyNotificationsScreen extends NavigationEvent {
  const OpenMyNotificationsScreen();

  @override
  List<Object?> get props => [];
}
