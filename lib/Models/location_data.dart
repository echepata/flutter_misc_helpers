import 'package:location/location.dart' as location_package;

/// @author    Diego
/// @since     2022-06-30
/// @copyright 2022 Carshare Australia Pty Ltd.

class LocationData {
  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double speed;
  final double speedAccuracy;
  final double heading;

  LocationData({
    this.latitude = 0,
    this.longitude = 0,
    double? accuracy,
    double? altitude,
    double? speed,
    double? speedAccuracy,
    double? heading,
  })  : accuracy = accuracy ?? 0,
        altitude = altitude ?? 0,
        speed = speed ?? 0,
        speedAccuracy = speedAccuracy ?? 0,
        heading = heading ?? 0;

  static LocationData fromLocationPackageLocationData(
    location_package.LocationData locationData,
  ) {
    return LocationData(
      latitude: locationData.latitude as double,
      longitude: locationData.longitude as double,
      speed: locationData.speed,
      speedAccuracy: locationData.speedAccuracy,
      heading: locationData.heading,
      accuracy: locationData.accuracy,
      altitude: locationData.altitude,
    );
  }
}
