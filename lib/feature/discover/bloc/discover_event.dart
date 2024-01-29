part of 'discover_bloc.dart';

abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object> get props => [];
}

class GetTopPosts extends DiscoverEvent {
  const GetTopPosts();
}

class LoadMore extends DiscoverEvent {
  const LoadMore();
}

class ChangeTimeRange extends DiscoverEvent {
  final TimeRange timeRange;
  const ChangeTimeRange({required this.timeRange});
}

class ReloadPosts extends DiscoverEvent {
  const ReloadPosts();
}
