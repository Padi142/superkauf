import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/library/app_module.dart';

import 'app_config.dart';

class App {
  factory App() => _instance;
  static App _instance = App._();

  factory App.newInstance() => _instance = App._();

  App._();

  static App get I => App();

  static App get instance => App();

  late AppConfig _appConfig;

  static AppConfig get appConfig => I._appConfig;

  final Map<String, WidgetBuilder> _routes = {};

  static Map<String, WidgetBuilder> get routes => I._routes;

  static ThemeData get appTheme => I._appTheme;

  late final ThemeData _appTheme;

  Future<void> init({
    required AppConfig config,
    required List<AppModule> modules,
    Function()? registerDependencies,
  }) async {
    _appConfig = config;
    GetIt.I.allowReassignment = true;

    if (registerDependencies != null) {
      registerDependencies();
    }

    //register modules
    for (final module in modules) {
      module.registerDI();
      module.registerRepo();
      module.registerNavigation();
      module.registerUseCase();
      module.registerBloc();
      module.registerScreen();
      module.registerRoute(_routes);
    }

    _appTheme = ThemeData(
      useMaterial3: false,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF7286D3),
        secondary: Color(0xFF8EA7E9),
        surface: Color(0xFFE5E0FF),
        background: Color(0xFFFFF2F2),
        error: Color(0xFFB00020),
        onPrimary: Color(0xFFFFFFFF),
        onSecondary: Color(0xFFFFFFFF),
        onSurface: Color(0xFF000000),
        onBackground: Color(0xFF000000),
        onError: Color(0xFFFFFFFF),
      ),
      primarySwatch: const MaterialColor(0xFF7286D3, <int, Color>{
        50: Color(0xFFFFF2F2),
        100: Color(0xFFE5E0FF),
        200: Color(0xFFE5E0FF),
        300: Color(0xFF8EA7E9),
        400: Color(0xFF8EA7E9),
        500: Color(0xFF7286D3), // primary color
        600: Color(0xFF7286D3), // primary color
        700: Color(0xFF7286D3), // primary color
        800: Color(0xFF7286D3), // primary color
      }),
    );
  }

  void run(Widget appWidget) {
    FlutterError.onError = (details) async {
      if (!kReleaseMode) {
        FlutterError.dumpErrorToConsole(details);
      } else if (details.stack != null) {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      }
    };

    runApp(
      EasyLocalization(
        key: UniqueKey(),
        supportedLocales: _appConfig.languages.map((lang) => Locale(lang)).toList(),
        path: 'assets/translations',
        fallbackLocale: const Locale('cs'),
        child: appWidget,
      ),
    );
  }
}

// custom text styles
extension CustomTextStyles on TextTheme {
  TextStyle get customTextStyle => TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: App.appTheme.primaryColor);
}

// custom colors
extension CustomColors on ThemeData {
  Color get failureColor => Colors.red;

  Color get successColor => Colors.green;

  Color get occupiedColor => Colors.orange;

  Color get secondaryColor => Colors.blue;

  Color get greyShadeColor => const Color(0xFFE8E8E8);
}
