part of 'store_posts_bloc.dart';

abstract class StorePostsEvent extends Equatable {
  const StorePostsEvent();

  @override
  List<Object> get props => [];
}

class GetPosts extends StorePostsEvent {
  final int storeId;

  const GetPosts({
    required this.storeId,
  });
}
