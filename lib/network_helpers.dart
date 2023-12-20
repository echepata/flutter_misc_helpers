import 'dart:io';

/// @author    Diego
/// @since     2022-08-03
/// @copyright 2022 Carshare Australia Pty Ltd.

class NetworkHelpers {
  static Future<bool> hasNetwork() async {
    try {
      // 8.8.8.8 is Google's DNS service
      final result = await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 2));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}