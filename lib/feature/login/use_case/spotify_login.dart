import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../library/use_case.dart';

class SpotifyLoginUseCase extends UnitUseCase<void> {
  SpotifyLoginUseCase();

  @override
  Future<void> call() async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signInWithOAuth(
      OAuthProvider.spotify,
      redirectTo: "io.padisoft.superkauf://login-callback/",
    );
  }
}
