import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_state.dart';
import 'package:superkauf/generic/post/use_case/get_posts_by_user.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_id_use_case.dart';

part 'user_detail_event.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final GetUserByIdUseCase getUserByIdUseCase;
  final GetPostsByUserUseCase getPostsByUserUseCase;

  UserDetailBloc({
    required this.getUserByIdUseCase,
    required this.getPostsByUserUseCase,
  }) : super(const UserDetailState.loading()) {
    on<GetUser>(_onGetUser);
    on<InitialUserEvent>(_onInitialUserEvent);
  }

  Future<void> _onGetUser(
    GetUser event,
    Emitter<UserDetailState> emit,
  ) async {
    late UserModel user;
    final result = await getUserByIdUseCase(event.userID);

    final postsResult = await getPostsByUserUseCase(event.userID);

    result.map(success: (success) {
      user = success.user;
    }, failure: (failure) {
      emit(UserDetailState.error(failure.message));
    });

    postsResult.map(success: (success) {
      emit(UserDetailState.loaded(
        user,
        success.response.posts,
      ));
    }, failure: (failure) {
      emit(UserDetailState.error(failure.message));
    });
  }

  Future<void> _onInitialUserEvent(
    InitialUserEvent event,
    Emitter<UserDetailState> emit,
  ) async {
    emit(UserDetailState.initial(event.user));
    add(GetUser(userID: event.user.id));
  }
}
