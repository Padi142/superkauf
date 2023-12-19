import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/library/app_navigation.dart';

import 'navigation_state.dart';

part 'navigation_event.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationStateLoaded(bottomNavIndex: 0, screenName: ScreenPath.feedScreen)) {
    on<OpenStoresScreen>(_onOpenStoresScreen);
    on<OpenDiscoverScreen>(_onOpenDiscoverScreen);
    on<OpenMyChannelScreen>(_onOpenMyChannelScreen);
    on<OpenFeedScreen>(_onOpenFeedScreen);
    on<OpenProfileScreen>(_onOpenProfileScreen);
    on<OpenShoppingListScreen>(_onOpenShoppingListScreen);
    on<GoToCreatePostScreen>(_onGoToCreatePostScreen);
  }

  var bottomBarIndex = 0;

  Future<void> _onOpenStoresScreen(
    OpenStoresScreen event,
    Emitter<NavigationState> emit,
  ) async {
    bottomBarIndex = 1;
    emit(NavigationStateLoaded(
      bottomNavIndex: event.index != null ? event.index! : bottomBarIndex,
      screenName: ScreenPath.storesScreen,
    ));
  }

  Future<void> _onOpenDiscoverScreen(
    OpenDiscoverScreen event,
    Emitter<NavigationState> emit,
  ) async {
    bottomBarIndex = 2;
    emit(NavigationStateLoaded(bottomNavIndex: event.index != null ? event.index! : bottomBarIndex, screenName: ScreenPath.discoverScreen));
  }

  Future<void> _onOpenMyChannelScreen(
    OpenMyChannelScreen event,
    Emitter<NavigationState> emit,
  ) async {
    bottomBarIndex = 3;
    emit(NavigationStateLoaded(bottomNavIndex: event.index != null ? event.index! : bottomBarIndex, screenName: ScreenPath.myChannelScreen));
  }

  Future<void> _onOpenFeedScreen(
    OpenFeedScreen event,
    Emitter<NavigationState> emit,
  ) async {
    bottomBarIndex = 0;
    emit(NavigationStateLoaded(bottomNavIndex: event.index != null ? event.index! : bottomBarIndex, screenName: ScreenPath.feedScreen));
  }

  Future<void> _onOpenProfileScreen(
    OpenProfileScreen event,
    Emitter<NavigationState> emit,
  ) async {
    AppNavigation().push(ScreenPath.profileScreen, replace: event.shouldReplace ? 1 : 0);
  }

  Future<void> _onOpenShoppingListScreen(
    OpenShoppingListScreen event,
    Emitter<NavigationState> emit,
  ) async {
    bottomBarIndex = 4;
    emit(NavigationStateLoaded(bottomNavIndex: event.index != null ? event.index! : bottomBarIndex, screenName: ScreenPath.shoppingListScreen));
  }

  Future<void> _onGoToCreatePostScreen(
    GoToCreatePostScreen event,
    Emitter<NavigationState> emit,
  ) async {
    AppNavigation().push(ScreenPath.createPostScreen);
  }
}
