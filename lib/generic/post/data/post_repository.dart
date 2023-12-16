import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/post_api.dart';
import 'package:superkauf/generic/post/model/get_posts_result.dart';

class PostsRepository {
  final PostApi postApi;

  PostsRepository({
    required this.postApi,
  });

  Future<GetPostsResult> getPosts() async {
    return postApi.getFeed().then((FeedPostModel) {
      return GetPostsResult.success(FeedPostModel);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetPostsResult.failure(error.message ?? 'error getting posts');
      }
      return const GetPostsResult.failure('error');
    });
  }
}
