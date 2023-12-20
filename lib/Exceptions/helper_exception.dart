/// @author    Diego
/// @since     2022-07-08
/// @copyright 2022 Carshare Australia Pty Ltd.

abstract class HelperException {
  final String message;

  const HelperException(this.message);

  @override
  String toString() {
    return 'HelperException: $message';
  }
}
