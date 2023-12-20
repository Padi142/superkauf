part of 'my_channel_bloc.dart';

abstract class MyChannelEvent extends Equatable {
  const MyChannelEvent();

  @override
  List<Object> get props => [];
}

class GetPosts extends MyChannelEvent {
  const GetPosts();
}
