import 'package:flutter/material.dart';

import 'app.dart';

class AppNavigation {
  static final AppNavigation _instance = AppNavigation._internal();

  static AppNavigationParams? navigationParams;

  factory AppNavigation() => _instance;
  AppNavigation._internal();

  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Future<void> push(
    String path, {
    bool root = false,
    int replace = 0,
    dynamic params,
  }) async {
    if (params != null) {
      AppNavigation.navigationParams = AppNavigationParams(path, params);
    }

    if (root) {
      await navigationKey.currentState?.pushNamedAndRemoveUntil(path, (_) => false, arguments: params);
      return;
    } else {
      if (replace > 0) {
        int actualReplace = 0;
        await navigationKey.currentState?.pushNamedAndRemoveUntil(path, (_) => actualReplace++ >= replace, arguments: params);
        return;
      } else {
        await navigationKey.currentState?.pushNamed(path, arguments: params);
      }
    }
  }

  Widget pathContent(String path, {dynamic params}) {
    if (navigationKey.currentState != null) {
      if (!App.routes.containsKey(path)) {
        return Container();
      }
      if (params != null) {
        AppNavigation.navigationParams = AppNavigationParams(path, params);
      }
      return ArgumentError.checkNotNull(App.routes[path])(navigationKey.currentState!.context);
    }
    return Container();
  }

  void pop({int popCount = 0, bool root = false}) {
    if (canPop()) {
      if (root) {
        navigationKey.currentState?.popUntil((route) => route.isFirst);
      } else if (popCount > 0) {
        int actualPop = 0;
        navigationKey.currentState?.popUntil((route) => actualPop++ >= popCount);
      } else {
        navigationKey.currentState?.pop();
      }
      return;
    }
  }

  void pushRoute(PageRoute route, {bool root = false}) {
    if (root) {
      navigationKey.currentState?.pushAndRemoveUntil<dynamic>(route, (_) => false);
      return;
    } else {
      navigationKey.currentState?.push<dynamic>(route);
      return;
    }
  }

  bool canPop() => navigationKey.currentState?.canPop() ?? false;
}

class AppNavigationParams {
  final String path;
  final dynamic params;

  AppNavigationParams(this.path, this.params);
}
