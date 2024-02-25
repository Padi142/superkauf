part of 'discover_bloc.dart';

abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object> get props => [];
}

class GetTopPosts extends DiscoverEvent {
  const GetTopPosts();
}

class Initial extends DiscoverEvent {
  const Initial();
}

class LoadMore extends DiscoverEvent {
  const LoadMore();
}

class ChangeTimeRange extends DiscoverEvent {
  final TimeRange timeRange;

  const ChangeTimeRange({required this.timeRange});
}

class ChangeSelectedStore extends DiscoverEvent {
  final StoreModel store;

  const ChangeSelectedStore({required this.store});
}

class ReloadPosts extends DiscoverEvent {
  const ReloadPosts();
}
