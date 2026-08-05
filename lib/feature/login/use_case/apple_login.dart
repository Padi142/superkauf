import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../library/use_case.dart';

typedef AppleNonceGenerator = String Function();
typedef AppleIdentityTokenProvider = Future<String?> Function({
  required String hashedNonce,
});
typedef AppleTokenExchange = Future<void> Function({
  required String identityToken,
  required String rawNonce,
});

class AppleLoginUseCase extends UnitUseCase<void> {
  final AppleNonceGenerator _nonceGenerator;
  final AppleIdentityTokenProvider _identityTokenProvider;
  final AppleTokenExchange _tokenExchange;

  AppleLoginUseCase({
    AppleNonceGenerator? nonceGenerator,
    AppleIdentityTokenProvider? identityTokenProvider,
    AppleTokenExchange? tokenExchange,
  })  : _nonceGenerator = nonceGenerator ?? _generateRawNonce,
        _identityTokenProvider =
            identityTokenProvider ?? _requestAppleIdentityToken,
        _tokenExchange = tokenExchange ?? _exchangeAppleIdentityToken;

  @override
  Future<void> call() async {
    final rawNonce = _nonceGenerator();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
    final identityToken = await _identityTokenProvider(
      hashedNonce: hashedNonce,
    );

    if (identityToken == null || identityToken.isEmpty) {
      throw const AuthException(
        'Apple did not return an identity token. Please try again.',
      );
    }

    await _tokenExchange(
      identityToken: identityToken,
      rawNonce: rawNonce,
    );
  }

  static String _generateRawNonce() {
    return Supabase.instance.client.auth.generateRawNonce();
  }

  static Future<String?> _requestAppleIdentityToken({
    required String hashedNonce,
  }) async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: const [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    return credential.identityToken;
  }

  static Future<void> _exchangeAppleIdentityToken({
    required String identityToken,
    required String rawNonce,
  }) async {
    await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: identityToken,
      nonce: rawNonce,
    );
  }
}
