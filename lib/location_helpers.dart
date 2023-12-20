import 'dart:math';
import 'package:fleetcutter_helpers/Exceptions/location_permissions_not_granted_exception.dart';
import 'package:fleetcutter_helpers/Exceptions/location_service_not_enabled_exception.dart';
import 'package:fleetcutter_helpers/Exceptions/map_could_not_be_launched_exception.dart';
import 'package:fleetcutter_helpers/Models/location_data.dart';
import 'package:fleetcutter_helpers/Models/location_data_pair.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart' as location_package;
import 'package:url_launcher/url_launcher.dart';

/// @author    Diego
/// @since     2022-06-30
/// @copyright 2022 Carshare Australia Pty Ltd.

class LocationHelpers {
  /// Throws [LocationServiceNotEnabledException] if the device does not support
  /// location services
  ///
  /// Throws [LocationPermissionsNotGrantedException] if the user has not
  /// granted permission to use the location
  static Future<LocationData> getLocation({
    bool enableBackgroundMode = false,
  }) async {
    location_package.Location location = location_package.Location();
    if (!kIsWeb) {
      location.enableBackgroundMode(enable: enableBackgroundMode);
    }

    await _requestLocationPermissionsIfMissing(location);

    location_package.LocationData data = await location.getLocation();
    return LocationData.fromLocationPackageLocationData(data);
  }

  static Future _requestLocationPermissionsIfMissing(
    location_package.Location location,
  ) async {
    bool serviceEnabled;
    location_package.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw LocationServiceNotEnabledException(
          "The location service is not enabled.",
        );
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == location_package.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != location_package.PermissionStatus.granted) {
        throw LocationPermissionsNotGrantedException(
          "The location permissions have not been granted.",
        );
      }
    }
  }

  /// Throws a [MapCouldNotBeLaunchedException] if the map application could not
  /// be launched.
  static Future<void> launchMap({
    required double lat,
    required double long,
  }) async {
    try {
      await tryGenericGeoProtocol(lat, long);
    } on MapCouldNotBeLaunchedException {
      try {
        await tryGoogleMapsProtocol(lat, long);
      } on MapCouldNotBeLaunchedException {
        await tryAppleMapsProtocol(lat, long);
      }
    }
  }

  static Future<void> tryGenericGeoProtocol(double lat, double long) async {
    Uri mapSchema = Uri(
      scheme: 'geo',
      path: '0,0',
      query: 'q=${lat.toStringAsFixed(5)},${long.toStringAsFixed(5)}',
    );

    if (await canLaunchUrl(mapSchema)) {
      await launchUrl(mapSchema);
    } else {
      throw MapCouldNotBeLaunchedException("The map could not be launched.");
    }
  }

  static Future<void> tryGoogleMapsProtocol(double lat, double long) async {
    Uri mapSchema = Uri(
      scheme: 'comgooglemaps',
      path: '//',
      query: 'center=${lat.toStringAsFixed(5)},${long.toStringAsFixed(5)}',
    );

    if (await canLaunchUrl(mapSchema)) {
      await launchUrl(mapSchema);
    } else {
      throw MapCouldNotBeLaunchedException("The map could not be launched.");
    }
  }

  static Future<void> tryAppleMapsProtocol(double lat, double long) async {
    Uri mapSchema = Uri(
      scheme: 'http',
      path: '//maps.apple.com/',
      query: 'll=${lat.toStringAsFixed(5)},${long.toStringAsFixed(5)}',
    );

    if (await canLaunchUrl(mapSchema)) {
      await launchUrl(mapSchema);
    } else {
      throw MapCouldNotBeLaunchedException("The map could not be launched.");
    }
  }

  static Future<void> tryGenericGeoProtocolWithAddress(String address) async {
    Uri mapSchema = Uri(
      scheme: 'geo',
      path: '0,0',
      queryParameters: {'q': address},
    );

    if (await canLaunchUrl(mapSchema)) {
      await launchUrl(mapSchema);
    } else {
      throw MapCouldNotBeLaunchedException("The map could not be launched.");
    }
  }

  static Future<void> tryGoogleMapsProtocolWithAddress(String address) async {
    Uri mapSchema = Uri(
      scheme: 'comgooglemaps',
      path: '//',
      queryParameters: {'q': address},
    );

    if (await canLaunchUrl(mapSchema)) {
      await launchUrl(mapSchema);
    } else {
      throw MapCouldNotBeLaunchedException("The map could not be launched.");
    }
  }

  static Future<void> tryAppleMapsProtocolWithAddress(String address) async {
    Uri mapSchema = Uri(
      scheme: 'http',
      path: '//maps.apple.com/',
      queryParameters: {'q': address},
    );

    if (await canLaunchUrl(mapSchema)) {
      await launchUrl(mapSchema);
    } else {
      throw MapCouldNotBeLaunchedException("The map could not be launched.");
    }
  }

  /// Throws a [MapCouldNotBeLaunchedException] if the map application could not
  /// be launched.
  static launchMapWithAddress({required String address}) async {
    try {
      await tryGenericGeoProtocolWithAddress(address);
    } on MapCouldNotBeLaunchedException {
      try {
        await tryGoogleMapsProtocolWithAddress(address);
      } on MapCouldNotBeLaunchedException {
        await tryAppleMapsProtocolWithAddress(address);
      }
    }
  }

  /// This method calculates and returns the distance between two coordinates,
  /// using the haversine method.
  ///
  /// Return value in meters
  static double calculateDistance(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    double latDiff = (lat2 - lat1) * pi / 180.0;
    double lngDiff = (lng2 - lng1) * pi / 180.0;

    // convert to radians
    double lat1Rad = (lat1) * pi / 180.0;
    double lat2Rad = (lat2) * pi / 180.0;

    // apply formula
    double a = pow(sin(latDiff / 2), 2) +
        pow(sin(lngDiff / 2), 2) * cos(lat1Rad) * cos(lat2Rad);
    // radius of earth in KM
    double earthRadius = 6371;
    double c = 2 * asin(sqrt(a));

    return earthRadius * c * 1000;
  }

  /// Calculates the coordinates for the corners of a square that has the given
  /// dimensions as the sides.
  ///
  /// The inverse haversine formula is very complex to solve mathematically, so
  /// we use numeric methods to solve this issue numerically
  static LocationDataPair getBoundsForSquareAroundCenter(
    double centerLat,
    double centerLong,
    int squareSideLength,
  ) {
    /// Make sure the given longitude is positive
    while (centerLong < 0) {
      centerLong += 360;
    }

    /// Reduce the given longitude to less than 1 rotation around the globe
    /// (>360 = 1+ rotations)
    centerLong = centerLong.remainder(360);

    /// These constraints are to stay within the area where the inverse
    /// haversine formula approximation will work without issues.  Around the
    /// poles this could behave unexpectedly, so we limit the range of this
    /// method.
    squareSideLength = min(200, squareSideLength.abs());
    centerLat = min(79, max(-56, centerLat));

    double longitudeChangePer100Kms =
        _getLongitudePer100KmApproximation(centerLat);

    /// 100km at sydney's longitude equal ~0.899094 latitude change (taken from
    /// google maps)
    double latitudeChangePer100Kms = 0.899094;
    double targetDistance = squareSideLength / 2;

    return LocationDataPair(
      LocationData(
        latitude: centerLat + latitudeChangePer100Kms / 100 * targetDistance,
        longitude: centerLong - longitudeChangePer100Kms / 100 * targetDistance,
      ),
      LocationData(
        latitude: centerLat - latitudeChangePer100Kms / 100 * targetDistance,
        longitude: centerLong + longitudeChangePer100Kms / 100 * targetDistance,
      ),
    );
  }

  /// This method returns the equivalent longitude change based on the latitude
  /// given. The amount returned is equivalent to a 100 km move at the same
  /// latitude. The formula used was generated using trendlines in excel, and
  /// the following data points
  ///
  ///     Lat    Long   100km west    Diff
  ///     ------------------------------------
  ///     -55    -70    -71.569156    1.569156
  ///     -50    -70    -71.401429    1.401429
  ///     -40    -65    -66.173987    1.173987
  ///     -30    25     23.961427     1.038573
  ///     -20    25     24.041261     0.958739
  ///     -10    25     24.086213     0.913787
  ///     0      115    114.100564    0.899436
  ///     10     25     24.083964     0.916036
  ///     20     25     24.04239      0.95761
  ///     30     25     23.960437     1.039563
  ///     40     70     68.824467     1.175533
  ///     50     70     68.600982     1.399018
  ///     60     70     68.200829     1.799171
  ///     70     100    97.364317     2.635683
  ///     80     -30    -35.179841    5.179841
  ///
  static double _getLongitudePer100KmApproximation(double latitude) {
    return 4E-11 * pow(latitude, 6) -
        6E-10 * pow(latitude, 5) -
        1E-07 * pow(latitude, 4) +
        2E-06 * pow(latitude, 3) +
        0.0003 * pow(latitude, 2) -
        0.001 * latitude +
        0.8636;
  }
}
