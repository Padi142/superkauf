import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../library/use_case.dart';
import '../model/login_params.dart';

class EmailRegisterUseCase extends UseCase<AuthResponse?, LoginParams> {
  EmailRegisterUseCase();

  @override
  Future<AuthResponse?> call(params) async {
    final supabase = Supabase.instance.client;

    try {
      final response = await supabase.auth.signUp(email: params.email, password: params.password);
      return response;
    } on AuthException catch (_, error) {
      print(error);
    } catch (e) {
      print(e);
    }

    return null;
  }
}
