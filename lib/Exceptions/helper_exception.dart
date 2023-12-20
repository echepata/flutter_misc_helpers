/// @author    Diego
/// @since     2022-07-08

abstract class HelperException {
  final String message;

  const HelperException(this.message);

  @override
  String toString() {
    return 'HelperException: $message';
  }
}
