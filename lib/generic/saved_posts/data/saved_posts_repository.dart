import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/saved_posts_api.dart';
import 'package:superkauf/generic/saved_posts/model/create_saved_post_body.dart';
import 'package:superkauf/generic/saved_posts/model/create_saved_post_result.dart';
import 'package:superkauf/generic/saved_posts/model/delete_saved_post_body.dart';
import 'package:superkauf/generic/saved_posts/model/delete_saved_post_model.dart';
import 'package:superkauf/generic/saved_posts/model/get_saved_post_params.dart';
import 'package:superkauf/generic/saved_posts/model/get_saved_post_result.dart';
import 'package:superkauf/generic/saved_posts/model/get_saved_posts_result.dart';
import 'package:superkauf/generic/saved_posts/model/update_saved_post_body.dart';

class SavedPostsRepository {
  final SavedPostsApi savedPostsApi;

  SavedPostsRepository({
    required this.savedPostsApi,
  });

  Future<GetSavedPostsResult> getSavedPosts(GetSavedPostsParams params) async {
    return savedPostsApi
        .getUserSavedPosts(
      id: params.userId,
      offset: params.pagination.offset,
      perPage: params.pagination.perPage,
    )
        .then((posts) {
      return GetSavedPostsResult.success(posts);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetSavedPostsResult.failure(error.message ?? 'error getting saved posts');
      }
      return const GetSavedPostsResult.failure('error');
    });
  }

  Future<CreateSavedPostResult> createSavedPost(CreateSavedPostBody body) async {
    return savedPostsApi.createSavedPost(body: body.toJson()).then((post) {
      return CreateSavedPostResult.success(post);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return CreateSavedPostResult.failure(error.message ?? 'error creating saved post');
      }
      return const CreateSavedPostResult.failure('error');
    });
  }

  Future<DeleteSavedPostResult> deleteSavedPost(DeleteSavedPostBody body) async {
    return savedPostsApi.deleteSavedPost(body: body.toJson()).then((post) {
      return DeleteSavedPostResult.success(post);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return DeleteSavedPostResult.failure(error.message ?? 'error deleting saved post');
      }
      return const DeleteSavedPostResult.failure('error');
    });
  }

  Future<GetSavedPostResult> updateSavedPost(UpdateSavedPostBody body) async {
    return savedPostsApi.updateSavedPost(body: body.toJson()).then((post) {
      return GetSavedPostResult.success(post);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetSavedPostResult.failure(error.message ?? 'error deleting saved post');
      }
      return const GetSavedPostResult.failure('error');
    });
  }
}
