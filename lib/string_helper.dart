import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

class StringHelper {
  static bool isEmailValid(String email) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email);
  }

  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}

String trimLeft(String from, String pattern) {
  if ((from).isEmpty || (pattern).isEmpty || pattern.length > from.length) {
    return from;
  }

  while (from.startsWith(pattern)) {
    from = from.substring(pattern.length);
  }
  return from;
}

String trimRight(String from, String pattern) {
  if ((from).isEmpty || (pattern).isEmpty || pattern.length > from.length) {
    return from;
  }

  while (from.endsWith(pattern)) {
    from = from.substring(0, from.length - pattern.length);
  }
  return from;
}

String trim(String from, String pattern) {
  return trimLeft(trimRight(from, pattern), pattern);
}

extension TrimAnyExtension on String {
  String trimAny(String char) {
    return trim(this, char);
  }

  String trimRightAny(String char) {
    return trimRight(this, char);
  }

  String trimLeftAny(String char) {
    return trimLeft(this, char);
  }
}
