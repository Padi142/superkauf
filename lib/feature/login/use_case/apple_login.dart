import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../library/use_case.dart';

class AppleLoginUseCase extends UnitUseCase<void> {
  AppleLoginUseCase();

  @override
  Future<void> call() async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectTo: "io.padisoft.superkauf://login-callback/",
    );
  }
}
