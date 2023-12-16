import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/feature/feed/feed_module.dart';
import 'package:superkauf/feature/home/home_module.dart';
import 'package:superkauf/feature/init/init_module.dart';
import 'package:superkauf/generic/api/post_api.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/locale/locale_resource.dart';
import 'package:superkauf/generic/post/posts_module.dart';
import 'package:superkauf/library/app_navigation.dart';

import 'library/app.dart';
import 'library/app_config.dart';
import 'library/app_module.dart';
import 'library/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_SECRET'),
    debug: true,
  );

  final AppConfig config = appConfig();

  GetIt.I.allowReassignment = true;

  Dio _dio(String endpoint) {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: endpoint,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(PrettyDioLogger());

    return dio;
  }

  App.instance.init(
    config: config,
    modules: modules(),
    registerDependencies: () {
      GetIt.I.registerFactory<LocaleResource>(
        () => LocaleResource(appConfig: config),
      );
      GetIt.I.registerFactory<PostApi>(() => PostApi(_dio(config.endpoint)));
    },
  );

  assert(config.languages.isNotEmpty);

  App.instance.run(const MainWidget());
}

AppConfig appConfig() {
  return AppConfig(
    endpoint: 'https://superkauf-api.krejzac.cz/', //'
    languages: ['en'],
    theme: MainTheme(),
  );
}

List<AppModule> modules() {
  return [
    InitModule(),
    HomeModule(),
    FeedModule(),
    PostModule(),
  ];
}

class MainTheme extends AppTheme {
  @override
  String get appFont => 'Poppins';

  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get colorPrimary => const Color(0xFFEC4899);

  @override
  Color get colorSecondary => const Color(0xff6366F1);

  @override
  Color get colorBlack => const Color(0xFF000000);

  @override
  Color get colorBackground1 => const Color(0xFF151133);

  @override
  Color get colorBackground2 => const Color(0xFF302B63);

  @override
  Color get colorBackground3 => const Color(0xFF24243E);

  @override
  Color get colorText => const Color(0xFFFFFFFF);

  @override
  Color get colorTextSecondary => const Color(0xff909090);

  @override
  Color get colorIcon => const Color(0xff344C73);

  @override
  Color get colorInactive => const Color(0xff2B2B2B);

  @override
  Color get colorNavbar => const Color(0xFFAFAFAF);

  @override
  Color get colorActive => const Color(0xFF222831);

  @override
  Color get colorActive2 => const Color(0xFF222222);

  @override
  Color get colorError => const Color(0xFFFF5252);

  @override
  Color get colorWarning => const Color(0xFFFFD200);

  @override
  Color get colorSuccess => const Color(0xFF009A38);
}

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      navigatorKey: AppNavigation().navigationKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: ScreenPath.initScreen,
      routes: App.routes,
      theme: App.appTheme,
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
