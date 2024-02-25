import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/feature/search/models/search_post_model.dart';

part 'search_state.freezed.dart';

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState.loading() = Loading;

  const factory SearchState.initial() = Initial;

  const factory SearchState.loaded(
    List<SearchPostModel> posts,
    // bool isLoading,
    // bool canLoadMore,
  ) = Loaded;

  const factory SearchState.error(String error) = Error;
}
