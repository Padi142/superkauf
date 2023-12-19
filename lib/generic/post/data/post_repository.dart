import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/post_api.dart';
import 'package:superkauf/generic/post/model/create_post_model.dart';
import 'package:superkauf/generic/post/model/create_post_result.dart';
import 'package:superkauf/generic/post/model/delete_post_body.dart';
import 'package:superkauf/generic/post/model/delete_post_result.dart';
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

  Future<CreatePostResult> createPost(CreatePostModel body) async {
    return postApi.createPost(body: body.toJson()).then((post) {
      return CreatePostResult.success(post);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return CreatePostResult.failure(error.message ?? 'error creating posts');
      }
      return CreatePostResult.failure(error.toString());
    });
  }

  Future<DeletePostResult> deletePost(DeletePostBody body) async {
    return postApi.deletePost(body: body.toJson()).then((post) {
      return const DeletePostResult.success();
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return DeletePostResult.failure(error.message ?? 'error deleting posts');
      }
      return DeletePostResult.failure(error.toString());
    });
  }
}
