import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../library/use_case.dart';
import '../model/login_params.dart';

class EmailLoginUseCase extends UseCase<AuthResponse?, LoginParams> {
  EmailLoginUseCase();

  @override
  Future<AuthResponse?> call(params) async {
    final supabase = Supabase.instance.client;

    try {
      final response = await supabase.auth.signInWithPassword(email: params.email, password: params.password);
      return response;
    } on AuthException catch (_, error) {
      print(error);
      final response = await supabase.auth.signUp(password: params.password, email: params.email);
    }
    try {
      final response = await supabase.auth.signInWithPassword(email: params.email, password: params.password);
      return response;
    } on AuthException catch (_, error) {
      print(error);

      final response = await supabase.auth.signUp(password: params.password, email: params.email);
    }

    return null;
  }
}
