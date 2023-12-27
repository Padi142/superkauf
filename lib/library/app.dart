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
  static ThemeData get appThemeDark => I._appThemeDark;

  late final ThemeData _appTheme;
  late final ThemeData _appThemeDark;

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
        displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Color(0xFF171116)),
        displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Color(0xFF171116)),
        displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF171116)),
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF171116)),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF171116)),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF171116)),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF171116)),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF171116)),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF171116)),
        bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF171116)),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF171116)),
        bodySmall: TextStyle(fontSize: 12, color: Color(0xFF171116)),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF171116)),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF171116)),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF171116)),
      ),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF7286D3),
        secondary: Color(0xFF8EA7E9),
        surface: Color(0xFFE5E0FF),
        background: Color(0xFFfaf5f9),
        tertiary: Color(0xFF171116),
        error: Color(0xFFB00020),
      ),

      // primarySwatch: const MaterialColor(0xFF7286D3, <int, Color>{
      //   50: Color(0xFFFFF2F2),
      //   100: Color(0xFFE5E0FF),
      //   200: Color(0xFFE5E0FF),
      //   300: Color(0xFF8EA7E9),
      //   400: Color(0xFF8EA7E9),
      //   500: Color(0xFF7286D3), // primary color
      //   600: Color(0xFF7286D3), // primary color
      //   700: Color(0xFF7286D3), // primary color
      //   800: Color(0xFF7286D3), // primary color
      // }),
    );

    _appThemeDark = ThemeData(
      useMaterial3: false,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black12,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Color(0xFFeee8ed)),
        displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Color(0xFFeee8ed)),
        displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFFeee8ed)),
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFeee8ed)),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFeee8ed)),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFeee8ed)),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFeee8ed)),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFeee8ed)),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFeee8ed)),
        bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFeee8ed)),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFFeee8ed)),
        bodySmall: TextStyle(fontSize: 12, color: Color(0xFFeee8ed)),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFeee8ed)),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFeee8ed)),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFeee8ed)),
      ),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFaf4b9b),
        secondary: Color(0xFF621e55),
        surface: Color(0xFFa9238c),
        background: Color(0xFF0a0509),
        tertiary: Color(0xFFeee8ed),
        error: Color(0xFFB00020),
      ),

      // primarySwatch: const MaterialColor(0xFF7286D3, <int, Color>{
      //   50: Color(0xFFFFF2F2),
      //   100: Color(0xFFE5E0FF),
      //   200: Color(0xFFE5E0FF),
      //   300: Color(0xFF8EA7E9),
      //   400: Color(0xFF8EA7E9),
      //   500: Color(0xFF7286D3), // primary color
      //   600: Color(0xFF7286D3), // primary color
      //   700: Color(0xFF7286D3), // primary color
      //   800: Color(0xFF7286D3), // primary color
      // }),
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
