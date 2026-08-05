import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../library/use_case.dart';
import '../model/login_params.dart';

class EmailRegisterUseCase extends UseCase<AuthResponse?, LoginParams> {
  EmailRegisterUseCase();

  @override
  Future<AuthResponse?> call(params) async {
    final supabase = Supabase.instance.client;

    return supabase.auth.signUp(
      email: params.email.trim(),
      password: params.password,
    );
  }
}
