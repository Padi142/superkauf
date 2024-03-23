import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/user/data/user_repository.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/library/use_case.dart';

class GetCurrentUserUseCase extends UseCase<UserModel?, bool> {
  UserRepository repository;

  GetCurrentUserUseCase({
    required this.repository,
  });

  @override
  Future<UserModel?> call(params) async {
    final prefs = await SharedPreferences.getInstance();

    if (params) {
      prefs.remove('user');
    }

    final String? storedUserData = prefs.getString('user');
    if (storedUserData != null) {
      try {
        return UserModel.fromJson(json.decode(storedUserData));
      } catch (e) {
        print(e);
      }
    }

    UserModel? returnUser;
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) {
      return null;
    }

    final result = await repository.getUserByUid(user.id);

    await result.map(
      success: (success) async {
        await prefs.setString('user', json.encode(success.user));
        returnUser = success.user;
      },
      failure: (failure) {
        returnUser = null;
      },
    );

    return returnUser;
  }
}
