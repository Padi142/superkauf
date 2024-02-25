import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meilisearch/meilisearch.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:superkauf/feature/search/bloc/search_state.dart';
import 'package:superkauf/feature/search/models/search_post_model.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/store/use_case/get_posts_by_store_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetPostsByStoreUseCase getPostsByStoreUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetSettingsUseCase getSettingsUseCase;

  SearchBloc({
    required this.getPostsByStoreUseCase,
    required this.getCurrentUserUseCase,
    required this.getSettingsUseCase,
  }) : super(const SearchState.initial()) {
    on<SearchPosts>(_onSearchEvent);
  }

  static const perPage = 5;
  var index = MeiliSearchClient(dotenv.env['SEARCH_API'] ?? '', dotenv.env['SEARCH_API_KEY'] ?? '').index('posts');

  Future<void> _onSearchEvent(
    SearchPosts event,
    Emitter<SearchState> emit,
  ) async {
    if (event.input.isEmpty) {
      emit(const SearchState.initial());
      return;
    }

    Posthog().capture(
      properties: {'searched_term': event.input},
      eventName: 'searched_posts',
    );

    var result = await index.search(event.input);

    final posts = result.hits.map((e) => SearchPostModel.fromJson(e)).toList();

    emit(SearchState.loaded(posts));
  }
}
