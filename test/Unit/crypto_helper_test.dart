/// @author    Diego
/// @since     2022-07-06
/// @copyright 2022 Carshare Australia Pty Ltd.

import 'package:fleetcutter_helpers/crypto_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CryptoHelper', () {
    test('Code verifier is generated correctly', () {
      var codeVerifier = CryptoHelper.generateCodeVerifier();
      expect(codeVerifier.length >= 43, true);
      codeVerifier = CryptoHelper.generateCodeVerifier();
      expect(codeVerifier.length >= 43, true);
      codeVerifier = CryptoHelper.generateCodeVerifier();
      expect(codeVerifier.length >= 43, true);
      codeVerifier = CryptoHelper.generateCodeVerifier();
      expect(codeVerifier.length >= 43, true);
      codeVerifier = CryptoHelper.generateCodeVerifier();
      expect(codeVerifier.length >= 43, true);
      codeVerifier = CryptoHelper.generateCodeVerifier();
      expect(codeVerifier.length >= 43, true);
    });

    test('Code challenge is generated correctly', () {
      Map expectations = {
        'ybAIjiYwWb7TUsnakAOTRfFZMl_qnk52E_QhVMO24UY':
            'b_-5al-Vo8nUmxkVNyi9H85gc1KZatmUj9azqV2vVuE',
        'dJOH6fL_Ocdq2fJc3sqlBXvI-BfgTjCJo-NpJoik6ZU':
            'kdXmpeSsjGP4dH0ZjTw7IPxa1d_W_86WPluDJod1OFk',
        'apIczfWL-hoMKwVO6xtsbfyxV1VLsNws_DlKHHQMU5o':
            '3t4kOGO21FRD9kIdejdgF6vUi3VRGyynNFjYAdm73OY',
        'O0pRg5PqM8BCvlF4Fb6heFkSU7vbSSOf30hdlo5QIi4':
            'D2spdHh2dG63wBTTqF65wXVsLjFlOEl-vq9i8PpSBRU',
        'tlbayDp-pOTpe1QVrdT23ZBcmtVj458NktbYiKZtlsY':
            'jM79zrcAEfVn4qBQCJrnNHWmrc34bSHjzWyKzz7oMPo',
        'yu5_LpvugmEmBrFGpS9gQyrztxeyyVRDfJVobKvROms':
            'B_Azevu6OsaQWSw4qhGrhyZAur90ngIIr8DTZlMzSpQ',
      };

      expectations.forEach((key, value) {
        var codeChallenge = CryptoHelper.createCodeChallenge(key);
        expect(codeChallenge == value, true);
      });
    });
  });
}
