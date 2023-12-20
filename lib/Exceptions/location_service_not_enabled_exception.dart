import 'package:fleetcutter_helpers/Exceptions/helper_exception.dart';

/// @author    Diego
/// @since     2022-06-30
/// @copyright 2022 Carshare Australia Pty Ltd.

class LocationServiceNotEnabledException extends HelperException {
  LocationServiceNotEnabledException(String message) : super(message);
}