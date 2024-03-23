import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../library/use_case.dart';

class GoogleLoginUseCase extends UnitUseCase<String?> {
  GoogleLoginUseCase();

  @override
  Future<String?> call() async {
    final webClientId = dotenv.env['FIREBASE_WEB_CLIENT_ID'] ?? '';
    final supabase = Supabase.instance.client;
    final GoogleSignIn googleSignIn = GoogleSignIn(serverClientId: webClientId);
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }
}
