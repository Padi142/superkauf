import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/post_api.dart';
import 'package:superkauf/generic/post/model/create_post_model.dart';
import 'package:superkauf/generic/post/model/create_post_result.dart';
import 'package:superkauf/generic/post/model/delete_post_body.dart';
import 'package:superkauf/generic/post/model/delete_post_result.dart';
import 'package:superkauf/generic/post/model/get_post_detail_result.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/get_posts_result.dart';
import 'package:superkauf/generic/post/model/models/add_reaction_model.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/generic/post/model/results/get_personal_feed_result.dart';
import 'package:superkauf/generic/post/model/results/reactions_result.dart';
import 'package:superkauf/generic/post/model/update_post_body.dart';
import 'package:superkauf/generic/post/model/update_post_image_body.dart';

class PostsRepository {
  final PostApi postApi;

  PostsRepository({
    required this.postApi,
  });

  Future<GetPostsResult> getPosts(GetPostsPaginationModel body) async {
    return postApi.getFeed(body: body.toJson()).then((posts) {
      return GetPostsResult.success(posts);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetPostsResult.failure(error.message ?? 'error getting posts');
      }
      return const GetPostsResult.failure('error');
    });
  }

  Future<GetPersonalFeedResult> getPersonalFeed(GetPostsPaginationModel body, int id) async {
    return postApi.getPersonalFeed(body: body.toJson(), id: id).then((posts) {
      return GetPersonalFeedResult.success(posts);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetPersonalFeedResult.failure(error.message ?? 'error getting posts');
      }
      return const GetPersonalFeedResult.failure('error');
    });
  }

  Future<GetPostsResult> getPostsByUser(int userID) async {
    return postApi.getPostsByUser(id: userID.toString()).then((posts) {
      return GetPostsResult.success(GetPostsResponseModel(posts: posts, pagination: const PaginationModel(count: 1, perPage: 1)));
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetPostsResult.failure(error.message ?? 'error getting posts');
      }
      return const GetPostsResult.failure('error');
    });
  }

  Future<GetPostDetailResult> getPostDetail(String postId) async {
    return postApi.getPostById(id: postId).then((post) {
      return GetPostDetailResult.success(post);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetPostDetailResult.failure(error.message ?? 'error getting posts');
      }
      return const GetPostDetailResult.failure('error');
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

  Future<GetPostDetailResult> updatePostImage(UpdatePostImageBody body) async {
    return postApi.updatePostImage(body: body.toJson()).then((post) {
      return GetPostDetailResult.success(post);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetPostDetailResult.failure(error.message ?? 'error deleting posts');
      }
      return GetPostDetailResult.failure(error.toString());
    });
  }

  Future<GetPostDetailResult> updatePostContent(UpdatePostBody body) async {
    return postApi.updatePostContent(body: body.toJson()).then((post) {
      return GetPostDetailResult.success(post);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetPostDetailResult.failure(error.message ?? 'error updating post');
      }
      return GetPostDetailResult.failure(error.toString());
    });
  }

  Future<ReactionsResult> addReaction(AddReactionModel body) async {
    return postApi.addReaction(body: body.toJson(), id: body.post.toString()).then((reaction) {
      return ReactionsResult.success(reaction);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return ReactionsResult.failure(error.message ?? 'error adding reaction');
      }
      return ReactionsResult.failure(error.toString());
    });
  }

  Future<ReactionsResult> removeReaction(RemoveReactionModel body) async {
    return postApi.removeReaction(body: body.toJson(), id: body.post.toString()).then((reaction) {
      return ReactionsResult.success(reaction);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return ReactionsResult.failure(error.message ?? 'error removing reaction');
      }
      return ReactionsResult.failure(error.toString());
    });
  }
}
