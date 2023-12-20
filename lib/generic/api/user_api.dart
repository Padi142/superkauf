import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio) = _UserApi;

  @GET('/user/id/{id}')
  Future<UserModel> getUserById({
    @Path() required int id,
  });

  @GET('/user/uid/{uid}')
  Future<UserModel> getUserByUid({
    @Path() required String uid,
  });

  @PUT('/user/id/{id}')
  Future<UserModel> updateUser({
    @Path() required int id,
    @Body() required Map<String, dynamic> body,
  });

  @POST('/user')
  Future<UserModel> createUser({
    @Body() required Map<String, dynamic> body,
  });
}
