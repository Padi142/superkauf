part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class GetFeed extends FeedEvent {
  const GetFeed();
}

class ReloadFeed extends FeedEvent {
  final bool wait;

  const ReloadFeed({this.wait = false});
}

class LoadMore extends FeedEvent {
  const LoadMore();
}
