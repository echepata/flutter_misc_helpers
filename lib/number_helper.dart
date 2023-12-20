import 'dart:math';
import 'package:flutter/foundation.dart';

/// @author    Diego
/// @since     2022-07-06

class NumberHelper {
  static double getRandomNumber(double lowerLimit, double higherLimit) {
    Random random = _getRandomGenerator();

    // normal is a number between 0 and 1, with 6 decimal places of precision
    double normal = random.nextInt(1000000) / 1000000;

    return normal * (higherLimit - lowerLimit).abs() +
        min(lowerLimit, higherLimit);
  }

  static Random _getRandomGenerator() {
    Random random = Random();

    try {
      random = Random.secure();
    } on UnsupportedError catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      random = Random(random.nextInt(100000));
    }

    return random;
  }

  /// This will check if the givenNumber is inclusive within 2 different numbers
  static bool isBetween(num givenNumber, num from, num to) {
    return givenNumber >= from && givenNumber <= to;
  }

  /// Round off a double value
  static double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
