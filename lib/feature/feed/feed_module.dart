import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/feed/bloc/feed_bloc.dart';
import 'package:superkauf/feature/feed/view/feed_view.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/post/use_case/get_posts_use_case.dart';

import '../../library/app_module.dart';

class FeedModule extends AppModule {
  @override
  void registerNavigation() {
    // GetIt.I.registerFactory<InitNavigation>(() => InitNavigation());
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<FeedBloc>(
      () => FeedBloc(getPostsUseCase: GetIt.I.get<GetPostsUseCase>()),
    );
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<FeedScreen>(() => FeedScreen());
  }

  @override
  void registerRoute(routes) {
    routes[FeedScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<FeedBloc>.value(
            value: GetIt.I.get<FeedBloc>(),
          ),
          BlocProvider<PostBloc>.value(
            value: GetIt.I.get<PostBloc>(),
          ),
        ],
        child: GetIt.I.get<FeedScreen>(),
      );
    };
  }
}
