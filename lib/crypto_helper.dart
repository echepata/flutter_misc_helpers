import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart' as crypto;
import 'package:crypto/crypto.dart';

/// @author    Diego
/// @since     2022-12-14

class CryptoHelper {
  /// [string] data being hashed
  static String md5(String string) {
    var bytes = utf8.encode(string);

    var digest = crypto.md5.convert(bytes);

    return digest.toString();
  }

  /// Generates a code verifier to be used with PKCE authorization
  static String generateCodeVerifier() {
    // Generate a random 32-byte sequence
    final generator = Random.secure();
    final codeVerifierBytes = Uint8List(32);
    for (var i = 0; i < codeVerifierBytes.length; i++) {
      codeVerifierBytes[i] = generator.nextInt(256);
    }

    // Base64 URL-encode the byte sequence
    final codeVerifierBase64 = base64Url.encode(codeVerifierBytes);

    return codeVerifierBase64.replaceAll('=', '');
  }

  /// Generates a code challenge to be used with PKCE authorization, based on an
  /// existing code verifier
  static String createCodeChallenge(String codeVerifier) {
    final codeVerifierBytes = utf8.encode(codeVerifier);
    final sha256Digest = sha256.convert(codeVerifierBytes);
    final codeChallenge = base64Url.encode(sha256Digest.bytes);

    return codeChallenge.replaceAll('=', '');
  }
}
