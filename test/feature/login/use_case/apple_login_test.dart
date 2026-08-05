import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/feature/login/use_case/apple_login.dart';

void main() {
  group('AppleLoginUseCase', () {
    test('exchanges a native Apple identity token with the matching nonce',
        () async {
      String? nonceSentToApple;
      String? tokenSentToSupabase;
      String? nonceSentToSupabase;

      final useCase = AppleLoginUseCase(
        nonceGenerator: () => 'fixed-raw-nonce',
        identityTokenProvider: ({required hashedNonce}) async {
          nonceSentToApple = hashedNonce;
          return 'apple-identity-token';
        },
        tokenExchange: ({required identityToken, required rawNonce}) async {
          tokenSentToSupabase = identityToken;
          nonceSentToSupabase = rawNonce;
        },
      );

      await useCase.call();

      expect(
        nonceSentToApple,
        '2ef03c79f10970c0bb581bf880657531b6a32cca461b8b2150e8de3a1e7e2964',
      );
      expect(tokenSentToSupabase, 'apple-identity-token');
      expect(nonceSentToSupabase, 'fixed-raw-nonce');
    });

    test('does not contact Supabase when Apple omits the identity token',
        () async {
      var exchangeCalled = false;
      final useCase = AppleLoginUseCase(
        nonceGenerator: () => 'fixed-raw-nonce',
        identityTokenProvider: ({required hashedNonce}) async => null,
        tokenExchange: ({required identityToken, required rawNonce}) async {
          exchangeCalled = true;
        },
      );

      await expectLater(useCase.call(), throwsA(isA<AuthException>()));
      expect(exchangeCalled, isFalse);
    });
  });
}
