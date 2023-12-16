import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'app.dart';

abstract class AppModule {
  void registerRepo() {}
  void registerUseCase() {}
  void registerBloc() {}
  void registerScreen() {}
  void registerNavigation() {}
  void registerRoute(Map<String, WidgetBuilder> routes) {}
  void registerDI() {}

  void registerDependencies() {
    registerRepo();
    registerNavigation();
    registerUseCase();
    registerBloc();
    registerScreen();
    registerRoute(App.routes);
    registerDI();
  }
}

class StaticHeaders extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.contentType = Headers.jsonContentType;
    return super.onRequest(options, handler);
  }
}
