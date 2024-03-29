import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/feed/bloc/feed_bloc.dart';
import 'package:superkauf/feature/home/bloc/saved_posts_panel_bloc/saved_posts_panel_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/feature/post_detail/view/post_detail_screen.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/comments/bloc/comment_bloc.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/post/use_case/get_post_detail_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_id_use_case.dart';

import '../../library/app_module.dart';

class PostDetailModule extends AppModule {
  @override
  void registerNavigation() {
    // GetIt.I.registerFactory<InitNavigation>(() => InitNavigation());
  }

  @override
  void registerBloc() {
    GetIt.I.registerSingleton<PostDetailBloc>(
      PostDetailBloc(
        getPostDetailUseCase: GetIt.I.get<GetPostDetailUseCase>(),
        getCurrentUserUseCase: GetIt.I.get<GetCurrentUserUseCase>(),
        getUserByIdUseCase: GetIt.I.get<GetUserByIdUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<PostDetailScreen>(() => PostDetailScreen());
  }

  @override
  void registerRoute(routes) {
    routes[PostDetailScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<PostBloc>.value(
            value: GetIt.I.get<PostBloc>(),
          ),
          BlocProvider<PostDetailBloc>.value(
            value: GetIt.I.get<PostDetailBloc>(),
          ),
          BlocProvider<FeedBloc>.value(
            value: GetIt.I.get<FeedBloc>(),
          ),
          BlocProvider<CommentBloc>.value(
            value: GetIt.I.get<CommentBloc>(),
          ),
          BlocProvider<SnackbarBloc>.value(
            value: GetIt.I.get<SnackbarBloc>(),
          ),
          BlocProvider<SavedPostsPanelBloc>.value(
            value: GetIt.I.get<SavedPostsPanelBloc>(),
          ),
        ],
        child: GetIt.I.get<PostDetailScreen>(),
      );
    };
  }
}
