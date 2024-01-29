import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_bloc.dart';
import 'package:superkauf/feature/user_detail/view/user_detail_screen.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/post/use_case/get_posts_by_user.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_id_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class UserDetailModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerRepo() {}

  @override
  void registerBloc() {
    GetIt.I.registerSingleton<UserDetailBloc>(
      UserDetailBloc(
        getUserByIdUseCase: GetIt.I.get<GetUserByIdUseCase>(),
        getPostsByUserUseCase: GetIt.I.get<GetPostsByUserUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<UserDetailScreen>(() => UserDetailScreen());
  }

  @override
  void registerUseCase() {}

  @override
  void registerRoute(routes) {
    routes[UserDetailScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<PostBloc>.value(
            value: GetIt.I.get<PostBloc>(),
          ),
        ],
        child: GetIt.I.get<UserDetailScreen>(),
      );
    };
  }
}
