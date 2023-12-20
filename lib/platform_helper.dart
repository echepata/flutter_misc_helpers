/// @author    Diego
/// @since     2022-05-12

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_misc_helpers/Enums/device_type.dart';
import 'package:flutter_misc_helpers/Enums/device_screen_type.dart';

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

  static bool isTest() {
    return Platform.environment.containsKey('FLUTTER_TEST');
  }
}

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double area = mediaQuery.size.width * mediaQuery.size.height;

  if (area < mediaQuery.textScaler.scale(230000)) {
    return DeviceScreenType.smallMobile;
  } else if (area < mediaQuery.textScaler.scale(500000)) {
    return DeviceScreenType.mobile;
  } else if (area < mediaQuery.textScaler.scale(1000000)) {
    return DeviceScreenType.tablet;
  } else {
    return DeviceScreenType.desktop;
  }
}
