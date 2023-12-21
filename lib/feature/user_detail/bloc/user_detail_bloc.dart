import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_state.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_id_use_case.dart';

part 'user_detail_event.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final GetUserByIdUseCase getUserByIdUseCase;

  UserDetailBloc({
    required this.getUserByIdUseCase,
  }) : super(const UserDetailState.loading()) {
    on<GetUser>(_onGetUser);
    on<InitialUserEvent>(_onInitialUserEvent);
  }

  Future<void> _onGetUser(
    GetUser event,
    Emitter<UserDetailState> emit,
  ) async {
    final result = await getUserByIdUseCase(event.userID);

    result.map(success: (success) {
      emit(UserDetailState.loaded(success.user));
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
