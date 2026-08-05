import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../library/use_case.dart';

class GoogleLoginUseCase extends UnitUseCase<String?> {
  static const MethodChannel _googleConfigChannel = MethodChannel(
    'io.padisoft.superkauf/google_sign_in_config',
  );
  static const List<String> _googleScopes = ['email', 'profile'];
  static Future<void>? _initializeFuture;

  GoogleLoginUseCase();

  @override
  Future<String?> call() async {
    final webClientId = dotenv.env['FIREBASE_WEB_CLIENT_ID'] ?? '';
    if (Platform.isIOS) {
      final googleConfig = await _googleConfigChannel.invokeMapMethod<String, dynamic>(
        'getGoogleSignInConfigurationStatus',
      );

      if (googleConfig == null || googleConfig['configured'] != true) {
        throw googleConfig?['message'] ??
            'Google Sign-In is not configured for iOS. Add GoogleService-Info.plist to ios/Runner.';
      }
    }

    final supabase = Supabase.instance.client;
    final googleSignIn = GoogleSignIn.instance;

    _initializeFuture ??= googleSignIn.initialize(
      serverClientId: webClientId.isNotEmpty ? webClientId : null,
    );
    await _initializeFuture;

    final googleUser = await googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;
    final idToken = googleAuth.idToken;
    final accessToken = _extractAccessToken(
      await googleUser.authorizationClient.authorizationHeaders(
        _googleScopes,
        promptIfNecessary: true,
      ),
    );

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

    return null;
  }

  String? _extractAccessToken(Map<String, String>? authHeaders) {
    if (authHeaders == null) {
      return null;
    }

    final authorizationHeader =
        authHeaders['Authorization'] ?? authHeaders['authorization'];
    if (authorizationHeader == null) {
      return null;
    }

    const bearerPrefix = 'Bearer ';
    if (!authorizationHeader.startsWith(bearerPrefix)) {
      return null;
    }

    return authorizationHeader.substring(bearerPrefix.length).trim();
  }
}
