part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchPosts extends SearchEvent {
  final String input;

  const SearchPosts({
    required this.input,
  });
}

// class ReloadStorePosts extends SearchEvent {
//   final bool wait;
//
//   const ReloadStorePosts({
//     this.wait = false,
//   });
// }
//
// class LoadMore extends SearchEvent {
//   final int storeId;
//
//   const LoadMore({
//     required this.storeId,
//   });
// }
