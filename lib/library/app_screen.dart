import 'package:flutter/material.dart';

import 'app_navigation.dart';

abstract class Screen<ARG extends Object> extends StatefulWidget {
  late final ARG? params;

  Screen(String path, {Key? key}) : super(key: key) {
    if (AppNavigation.navigationParams?.path == path) {
      if (AppNavigation.navigationParams?.params != null && AppNavigation.navigationParams?.params is ARG) {
        params = AppNavigation.navigationParams!.params as ARG;
      } else {
        params = null;
      }
      AppNavigation.navigationParams = null;
    } else {
      params = null;
    }
  }
}
