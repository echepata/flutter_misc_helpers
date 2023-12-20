import 'package:flutter/material.dart';

/// @author    Diego
/// @since     2022-09-29

class PixelSizeHelper {
  @Deprecated("This should no longer be used")
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  /// This helper method will return an equivalent pixel size, depending on the
  /// textScaleFactor that has been set on the phone.
  static int realSize(BuildContext context, int desiredSize) {
    return (MediaQuery.of(context).textScaler.scale(desiredSize.toDouble()))
        .round();
  }
}
