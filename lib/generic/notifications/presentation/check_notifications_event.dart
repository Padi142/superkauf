part of 'check_notifications_bloc.dart';

abstract class CheckNotificationEvent extends Equatable {
  const CheckNotificationEvent();

  @override
  List<Object> get props => [];
}

class CheckNotifications extends CheckNotificationEvent {
  const CheckNotifications();
}

class ClearNotifications extends CheckNotificationEvent {
  const ClearNotifications();
}
