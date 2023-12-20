import 'package:flutter_misc_helpers/Exceptions/helper_exception.dart';

/// @author    Diego
/// @since     2022-06-30

class LocationPermissionsNotGrantedException extends HelperException {
  LocationPermissionsNotGrantedException(String message) : super(message);
}
