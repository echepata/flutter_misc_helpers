/// @author    Diego
/// @since     2022-07-06
/// @copyright 2022 Carshare Australia Pty Ltd.

import 'package:fleetcutter_helpers/dates_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DatesHelper', () {
    test('Duration is converted correctly to string', () {
      String result = '';
      result = DatesHelper.durationToString(
        const Duration(days: 3, hours: 2, minutes: 45, seconds: 9),
      );
      expect(result, '3 days, 2 hours and 45 minutes');
      result = DatesHelper.durationToString(
        const Duration(days: 3, hours: 45, minutes: 800, seconds: 78),
      );
      expect(result, '5 days, 10 hours and 21 minutes');
      result = DatesHelper.durationToString(
        const Duration(days: 0, hours: 2, minutes: 20, seconds: 78),
      );
      expect(result, '2 hours and 21 minutes');
      // Seconds are rounded to the nearest minute
      result = DatesHelper.durationToString(
        const Duration(days: 0, hours: 1, minutes: 0, seconds: 59),
      );
      expect(result, '1 hour and 1 minute');
      result = DatesHelper.durationToString(
        const Duration(days: 0, hours: 1, minutes: 0, seconds: 0),
      );
      expect(result, '1 hour');
      result = DatesHelper.durationToString(
        const Duration(days: 0, hours: 2, minutes: 0, seconds: 0),
      );
      expect(result, '2 hours');
      result = DatesHelper.durationToString(
        const Duration(days: 1, hours: 1, minutes: 1, seconds: 0),
      );
      expect(result, '1 day, 1 hour and 1 minute');
      result = DatesHelper.durationToString(
        const Duration(days: 1, hours: 0, minutes: 0, seconds: 0),
      );
      expect(result, '1 day');
      result = DatesHelper.durationToString(
        const Duration(days: 2, hours: 0, minutes: 0, seconds: 0),
      );
      expect(result, '2 days');
      result = DatesHelper.durationToString(
        const Duration(days: 0, hours: 0, minutes: 1, seconds: 0),
      );
      expect(result, '1 minute');
      result = DatesHelper.durationToString(
        const Duration(days: 0, hours: 0, minutes: 2, seconds: 0),
      );
      expect(result, '2 minutes');
      result = DatesHelper.durationToString(const Duration(minutes: 0));
      expect(result, '0 minutes');
      result = DatesHelper.durationToString(const Duration(seconds: -92));
      expect(result, '2 minutes');
    });

    test('Time difference is converted correctly to string', () {
      String result = '';
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 13, 15, 30, 00),
      );
      expect(result, '3 days 2.8 hours');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 15, 23, 06, 00),
      );
      expect(result, '5 days 10.4 hours');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 10, 15, 06, 00),
      );
      expect(result, '2.4 hours');
      // Seconds are rounded to the nearest minute
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 10, 13, 46, 00),
      );
      expect(result, '1 hour');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 10, 13, 45, 00),
      );
      expect(result, '1 hour');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 10, 14, 45, 00),
      );
      expect(result, '2 hours');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 11, 13, 46, 00),
      );
      expect(result, '1 day 1 hour');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 11, 12, 45, 00),
      );
      expect(result, '1 day');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 11, 13, 15, 00),
      );
      expect(result, '1 day 30 minutes');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 12, 12, 45, 00),
      );
      expect(result, '2 days');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 10, 12, 46, 00),
      );
      expect(result, '--');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 10, 12, 47, 00),
      );
      expect(result, '--');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 10, 12, 45, 00),
      );
      expect(result, '--');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 10, 12, 45, 00),
        DateTime(2023, 11, 10, 12, 43, 00),
      );
      expect(result, '--');
      result = DatesHelper.getTotalTimeDuration(
        DateTime(2023, 11, 14, 12, 45, 00),
        DateTime(2023, 11, 12, 12, 45, 00),
      );
      expect(result, '--');
    });
  });
}
