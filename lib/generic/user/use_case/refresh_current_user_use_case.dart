import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/user/data/user_repository.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/library/use_case.dart';

class RefreshCurrentUserUseCase extends UnitUseCase<UserModel?> {
  UserRepository repository;

  RefreshCurrentUserUseCase({
    required this.repository,
  });

  @override
  Future<UserModel?> call() async {
    final box = await Hive.openBox('user');

    UserModel? returnUser;
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) {
      return null;
    }

    final result = await repository.getUserByUid(user.id);

    result.map(
      success: (success) async {
        await box.put('user', json.encode(success.user));
        returnUser = success.user;
      },
      failure: (failure) {
        returnUser = null;
      },
    );

    return returnUser;
  }
}
