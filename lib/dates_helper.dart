import 'package:fleetcutter_helpers/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// @author    Diego
/// @since     2022-07-27
/// @copyright 2022 Carshare Australia Pty Ltd.

class DatesHelper {
  static bool areInSameDay(DateTime time1, DateTime time2) {
    return time1.year == time2.year &&
        time1.month == time2.month &&
        time1.day == time2.day;
  }

  static Future<DateTime?> showDateAndTimePicker({
    required BuildContext context,
    required DateTime initialDateTime,
    required DateTime firstDateTime,
    required DateTime lastDateTime,
    String? dateHelpText,
    String? timeHelpText,
  }) async {
    return _showDateAndTimePicker(
      context: context,
      initialDateTime: initialDateTime,
      firstDateTime: firstDateTime,
      lastDateTime: lastDateTime,
      dateHelpText: dateHelpText,
      timeHelpText: timeHelpText,
    );
  }

  static Future<DateTime?> _showDateAndTimePicker({
    required BuildContext context,
    required DateTime initialDateTime,
    required DateTime firstDateTime,
    required DateTime lastDateTime,
    String? dateHelpText,
    String? timeHelpText,
    DateTime? date,
  }) async {
    date ??= await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: firstDateTime,
      lastDate: lastDateTime,
      helpText: dateHelpText,
      confirmText: 'CONTINUE',
    );

    if (date is DateTime) {
      if (context.mounted) {
        TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(
            hour: initialDateTime.hour,
            minute: initialDateTime.minute,
          ),
          helpText: timeHelpText,
          cancelText: 'BACK',
        );

        if (context.mounted) {
          if (time is TimeOfDay) {
            DateTime newDateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );

            if (newDateTime.isBefore(firstDateTime)) {
              showToastMessage(
                'The date selected is before the limit. ${firstDateTime.toString()}',
              );
              return _showDateAndTimePicker(
                context: context,
                initialDateTime: initialDateTime,
                firstDateTime: firstDateTime,
                lastDateTime: lastDateTime,
                dateHelpText: dateHelpText,
                timeHelpText: timeHelpText,
                date: date,
              );
            } else if (newDateTime.isAfter(lastDateTime)) {
              showToastMessage(
                'The date selected is after the limit. ${lastDateTime.toString()}',
              );
              return _showDateAndTimePicker(
                context: context,
                initialDateTime: initialDateTime,
                firstDateTime: firstDateTime,
                lastDateTime: lastDateTime,
                dateHelpText: dateHelpText,
                timeHelpText: timeHelpText,
                date: date,
              );
            } else {
              return newDateTime;
            }
          } else {
            DateTime newInitialDateTime = DateTime(
              date.year,
              date.month,
              date.day,
              initialDateTime.hour,
              initialDateTime.minute,
            );

            return _showDateAndTimePicker(
              context: context,
              initialDateTime: newInitialDateTime,
              firstDateTime: firstDateTime,
              lastDateTime: lastDateTime,
              dateHelpText: dateHelpText,
              timeHelpText: timeHelpText,
            );
          }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static String durationToString(Duration duration) {
    List<String> parts = [];
    duration = duration.abs();
    int extraMinute = ((duration.inSeconds % 60) / 60).round();
    Duration roundedDuration =
        Duration(minutes: duration.inMinutes + extraMinute);

    int restDays = roundedDuration.inDays;
    if (restDays > 0) {
      parts.add('$restDays day${restDays > 1 ? 's' : ''}');
    }
    int restHours = (roundedDuration.inHours % 24).round();
    if (restHours > 0) {
      parts.add('$restHours hour${restHours > 1 ? 's' : ''}');
    }
    int restMinutes = (roundedDuration.inMinutes % 60).round();
    if (restMinutes % 60 > 0 || parts.isEmpty) {
      parts.add('$restMinutes minute${restMinutes != 1 ? 's' : ''}');
    }
    String lastPart = parts.last;
    parts.remove(lastPart);

    String csv = parts.join(', ');
    String rest = csv.isNotEmpty ? (' and $lastPart') : lastPart;

    return csv + rest;
  }

  /// Creates a [String] date using the format specified by [format]
  static String getFormattedDate(String format, DateTime dateTime) {
    String formattedDate = DateFormat(format).format(dateTime);
    return formattedDate;
  }

  /// Creates a [String] date with suffix using the [DateTime] provided
  static String getDayOfMonthSuffix(DateTime dateTime) {
    String formattedDate = DateFormat('dd').format(dateTime);
    int dayNum = int.parse(formattedDate);
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return '${dayNum}th';
    }

    switch (dayNum % 10) {
      case 1:
        return '${dayNum}st';
      case 2:
        return '${dayNum}nd';
      case 3:
        return '${dayNum}rd';
      default:
        return '${dayNum}th';
    }
  }

  /// Creates a [String] total duration of 2 dates using the DateTime [startDate]
  /// and DateTime [endDate]. The expected format for this is d days h hours
  /// e.g [2 days 1.5 hours]
  static String getTotalTimeDuration(DateTime startDate, DateTime endDate) {
    final totalTimeDuration = endDate.difference(startDate);

    final days = totalTimeDuration.inDays;
    final hours = (totalTimeDuration.inHours.remainder(24));
    final minutes = totalTimeDuration.inMinutes.remainder(60);
    final hourFraction = (minutes / 60 * 10).round();

    final daysStr = days > 1 ? 'days' : 'day';
    final hoursStr = hours > 1 ? 'hours' : 'hour';
    final minutesStr = minutes > 1 ? 'minutes' : 'minute';

    if (days > 0 && minutes > 0 && hours == 0) {
      return '$days $daysStr $minutes $minutesStr';
    } else if (days > 0 && hours > 0) {
      return '$days $daysStr $hours${hourFraction == 0 ? '' : '.$hourFraction'} $hoursStr';
    } else if (days > 0) {
      return '$days $daysStr';
    } else if (hours > 0) {
      return '$hours${hourFraction == 0 ? '' : '.$hourFraction'} $hoursStr';
    } else {
      return '--';
    }
  }
}
