/// @author    Diego
/// @since     2022-05-12
/// @copyright 2022 Carshare Australia Pty Ltd.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:fleetcutter_helpers/Enums/device_type.dart';
import 'package:fleetcutter_helpers/Enums/device_screen_type.dart';

class PlatformInfo {
  static bool isDesktopOS() {
    try {
      return Platform.isMacOS || Platform.isLinux || Platform.isWindows;
    } catch (e) {
      return false;
    }
  }

  static bool isAppOS() {
    try {
      return Platform.isIOS || Platform.isAndroid;
    } catch (e) {
      return false;
    }
  }

  static bool isWeb() {
    try {
      return kIsWeb;
    } catch (e) {
      return false;
    }
  }

  static PlatformType getCurrentPlatformType() {
    try {
      if (kIsWeb) {
        return PlatformType.web;
      }

      if (Platform.isMacOS) {
        return PlatformType.macOs;
      }

      if (Platform.isFuchsia) {
        return PlatformType.fuchsia;
      }

      if (Platform.isLinux) {
        return PlatformType.linux;
      }

      if (Platform.isWindows) {
        return PlatformType.windows;
      }

      if (Platform.isIOS) {
        return PlatformType.iOs;
      }

      if (Platform.isAndroid) {
        return PlatformType.android;
      }
    } catch (e) {
      // do nothing, return unknown
    }
    return PlatformType.unknown;
  }
}

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double area = mediaQuery.size.width * mediaQuery.size.height;

  if (area < 230000 * mediaQuery.textScaleFactor) {
    return DeviceScreenType.smallMobile;
  } else if (area < 500000 * mediaQuery.textScaleFactor) {
    return DeviceScreenType.mobile;
  } else if (area < 1000000 * mediaQuery.textScaleFactor) {
    return DeviceScreenType.tablet;
  } else {
    return DeviceScreenType.desktop;
  }
}
