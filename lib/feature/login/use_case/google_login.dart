import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../library/use_case.dart';

class GoogleLoginUseCase extends UnitUseCase<void> {
  GoogleLoginUseCase();

  @override
  Future<void> call() async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: "io.padisoft.superkauf://login-callback/",
    );
  }
}
