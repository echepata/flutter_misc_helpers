import 'package:fleetcutter_helpers/Exceptions/helper_exception.dart';

/// @author    Diego
/// @since     2022-07-05
/// @copyright 2022 Carshare Australia Pty Ltd.

class MapCouldNotBeLaunchedException extends HelperException {
  MapCouldNotBeLaunchedException(String message) : super(message);
}