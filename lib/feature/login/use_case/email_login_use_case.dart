import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../library/use_case.dart';
import '../model/login_params.dart';

class EmailLoginUseCase extends UseCase<AuthResponse?, LoginParams> {
  EmailLoginUseCase();

  @override
  Future<AuthResponse?> call(params) async {
    final supabase = Supabase.instance.client;

    return supabase.auth.signInWithPassword(
      email: params.email.trim(),
      password: params.password,
    );
  }
}
