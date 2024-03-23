part of 'my_notifications_bloc.dart';

abstract class MyNotificationsEvent extends Equatable {
  const MyNotificationsEvent();

  @override
  List<Object> get props => [];
}

class GetNotifications extends MyNotificationsEvent {
  const GetNotifications();
}

class LoadMore extends MyNotificationsEvent {
  const LoadMore();
}

class ReloadNotifications extends MyNotificationsEvent {
  final bool wait;

  const ReloadNotifications({this.wait = false});
}
