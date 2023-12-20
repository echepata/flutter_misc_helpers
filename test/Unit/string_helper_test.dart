/// @author    Diego
/// @since     2022-07-06
/// @copyright 2022 Carshare Australia Pty Ltd.

import 'package:fleetcutter_helpers/string_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringHelper', () {
    test('trim any works ok', () {
      const sample = '###Hello world///';
      final trimmed = sample.trimAny('#');
      expect(trimmed, 'Hello world///');
    });
    test('trim any works ok 2', () {
      const sample = '###Hello world///';
      final trimmed = sample.trimAny('/');
      expect(trimmed, '###Hello world');
    });
    test('trim any works ok 3', () {
      const sample = '###Hello world///';
      final trimmed = sample.trimAny('/').trimAny('#');
      expect(trimmed, 'Hello world');
    });
    test('trim any right works ok 1', () {
      const sample = '###Hello world///';
      final trimmed = sample.trimRightAny('/');
      expect(trimmed, '###Hello world');
    });
    test('trim any right works ok 2', () {
      const sample = '###Hello world///';
      final trimmed = sample.trimRightAny('#');
      expect(trimmed, '###Hello world///');
    });
    test('trim any left works ok 1', () {
      const sample = '###Hello world///';
      final trimmed = sample.trimLeftAny('#');
      expect(trimmed, 'Hello world///');
    });
    test('trim any left works ok 2', () {
      const sample = '###Hello world///';
      final trimmed = sample.trimLeftAny('/');
      expect(trimmed, '###Hello world///');
    });
  });
}
