import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/generic/notifications/presentation/check_notifications_state.dart';
import 'package:superkauf/generic/notifications/user_case/check_notifications_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

part 'check_notifications_event.dart';

class CheckNotificationBloc extends Bloc<CheckNotificationEvent, CheckNotificationsState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CheckNotificationUseCase checkNotificationsUseCase;

  CheckNotificationBloc({
    required this.getCurrentUserUseCase,
    required this.checkNotificationsUseCase,
  }) : super(const CheckNotificationsState.loading()) {
    on<CheckNotifications>(_onCheckNotifications);
    on<ClearNotifications>(_onClearNotifications);
  }

  Future<void> _onCheckNotifications(
    CheckNotifications event,
    Emitter<CheckNotificationsState> emit,
  ) async {
    emit(const CheckNotificationsState.loading());
    final currentUser = await getCurrentUserUseCase.call(false);

    if (currentUser == null) {
      return;
    }
    final result = await checkNotificationsUseCase.call(currentUser.id);
    result.when(
      success: (success) {
        emit(CheckNotificationsState.success(success));
      },
      failure: (message) {
        emit(CheckNotificationsState.error(message));
      },
    );
  }

  Future<void> _onClearNotifications(
    ClearNotifications event,
    Emitter<CheckNotificationsState> emit,
  ) async {
    emit(const CheckNotificationsState.error('Bleegh :PP'));
  }
}
