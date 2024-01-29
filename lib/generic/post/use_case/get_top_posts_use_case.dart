import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/post/model/results/get_paginated_feed_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetTopPostsUseCase extends UseCase<GetPersonalFeedResult, GetTopPostsParams> {
  PostsRepository repository;

  GetTopPostsUseCase({
    required this.repository,
  });

  @override
  Future<GetPersonalFeedResult> call(params) async {
    return await repository.getTopPosts(params.pagination, params.userId, params.timeRange);
  }
}
