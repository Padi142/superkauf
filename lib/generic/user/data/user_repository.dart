import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/user_api.dart';
import 'package:superkauf/generic/post/use_case/update_user_body.dart';
import 'package:superkauf/generic/user/model/get_user_result.dart';

class UserRepository {
  final UserApi userApi;

  UserRepository({
    required this.userApi,
  });

  Future<GetUserResult> getUserById(int id) async {
    return userApi.getUserById(id: id).then((user) {
      return GetUserResult.success(user);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetUserResult.failure(error.message ?? 'error getting user');
      }
      return const GetUserResult.failure('error');
    });
  }

  Future<GetUserResult> getUserByUid(String uid) async {
    return userApi.getUserByUid(uid: uid).then((user) {
      return GetUserResult.success(user);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetUserResult.failure(error.message ?? 'error getting user');
      }
      return const GetUserResult.failure('error');
    });
  }

  Future<GetUserResult> updateUser(int id, UpdateUserBody body) async {
    return userApi.updateUser(id: id, body: body.toJson()).then((user) {
      return GetUserResult.success(user);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetUserResult.failure(error.message ?? 'error updating user');
      }
      return const GetUserResult.failure('error');
    });
  }
}
