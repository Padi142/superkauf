import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/generic/notifications/user_case/get_notifications_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

import 'my_notifications_state.dart';

part 'my_notifications_event.dart';

class MyNotificationsBloc extends Bloc<MyNotificationsEvent, MyNotificationsState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetNotificationsUseCase getNotificationsUseCase;

  MyNotificationsBloc({
    required this.getCurrentUserUseCase,
    required this.getNotificationsUseCase,
  }) : super(const MyNotificationsState.loading()) {
    on<GetNotifications>(_onGetNotifications);
  }

  var userId = -1;

  Future<void> _onGetNotifications(
    GetNotifications event,
    Emitter<MyNotificationsState> emit,
  ) async {
    emit(const MyNotificationsState.loading());

    final user = await getCurrentUserUseCase.call();

    if (user == null) {
      emit(const MyNotificationsState.error("You are not logged in"));
      return;
    }

    final result = await getNotificationsUseCase.call(user.id);

    result.map(success: (success) {
      emit(MyNotificationsState.loaded(success.notifications));
    }, failure: (failure) {
      emit(MyNotificationsState.error(failure.message));
    });
  }
}
