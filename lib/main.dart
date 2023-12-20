import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/feature/account/account_module.dart';
import 'package:superkauf/feature/create_post/create_post_module.dart';
import 'package:superkauf/feature/feed/feed_module.dart';
import 'package:superkauf/feature/home/home_module.dart';
import 'package:superkauf/feature/init/init_module.dart';
import 'package:superkauf/feature/login/login_module.dart';
import 'package:superkauf/feature/my_channel/my_channel_module.dart';
import 'package:superkauf/feature/post_detail/post_detail_module.dart';
import 'package:superkauf/feature/store_posts/store_posts_module.dart';
import 'package:superkauf/generic/api/post_api.dart';
import 'package:superkauf/generic/api/store_api.dart';
import 'package:superkauf/generic/api/user_api.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/locale/locale_resource.dart';
import 'package:superkauf/generic/post/posts_module.dart';
import 'package:superkauf/generic/store/store_module.dart';
import 'package:superkauf/generic/user/user_module.dart';
import 'package:superkauf/library/app_navigation.dart';

import 'library/app.dart';
import 'library/app_config.dart';
import 'library/app_module.dart';
import 'library/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_SECRET'] ?? '',
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ));

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
      GetIt.I.registerFactory<UserApi>(() => UserApi(_dio(config.endpoint)));
      GetIt.I.registerFactory<StoreApi>(() => StoreApi(_dio(config.endpoint)));
    },
  );

  assert(config.languages.isNotEmpty);

  App.instance.run(const MainWidget());
}

AppConfig appConfig() {
  return AppConfig(
    endpoint: dotenv.env['API_URL'] ?? '',
    languages: ['en'],
    theme: MainTheme(),
  );
}

List<AppModule> modules() {
  return [
    PostModule(),
    InitModule(),
    HomeModule(),
    FeedModule(),
    LoginModule(),
    AccountModule(),
    CreatePostModule(),
    MyChannelModule(),
    UserModule(),
    PostDetailModule(),
    StoreModule(),
    StorePostsModule(),
  ];
}

class MainTheme extends AppTheme {
  @override
  String get appFont => 'Poppins';

  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get colorPrimary => const Color(0xFF7286D3);

  @override
  Color get colorSecondary => const Color(0xff8EA7E9);

  @override
  Color get colorBlack => const Color(0xFF000000);

  @override
  Color get colorBackground => const Color(0xFFFFF2F2);

  @override
  Color get colorText => const Color(0xFFFFFFFF);

  @override
  Color get colorTextSecondary => const Color(0xff909090);

  @override
  Color get colorIcon => const Color(0xff344C73);

  @override
  Color get colorInactive => const Color(0xffE5E0FF);

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
      showSemanticsDebugger: false,
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
