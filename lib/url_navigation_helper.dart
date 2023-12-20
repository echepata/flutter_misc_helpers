import 'package:fleetcutter_helpers/Exceptions/url_could_not_be_opened_exception.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

/// @author    Diego
/// @since     2022-07-08
/// @copyright 2022 Carshare Australia Pty Ltd.

class UrlNavigationHelper {

  static const Map<LaunchMode, url_launcher.LaunchMode> launchModeMap = {
    LaunchMode.platformDefault: url_launcher.LaunchMode.platformDefault,
    LaunchMode.inAppWebView: url_launcher.LaunchMode.inAppWebView,
    LaunchMode.externalApplication: url_launcher.LaunchMode.externalApplication,
    LaunchMode.externalNonBrowserApplication: url_launcher.LaunchMode.externalNonBrowserApplication,
  };

  /// Throws [UrlCouldNotBeOpenedException] if the url could not be opened. This may be due to an
  /// invalid url structure
  static Future<void> goToUrl(String url, {LaunchMode mode = LaunchMode.platformDefault}) async {
    Uri uriSchema = Uri.parse(url);

    if (await url_launcher.canLaunchUrl(uriSchema)) {
      await url_launcher.launchUrl(uriSchema, mode: launchModeMap[mode] as url_launcher.LaunchMode);
    } else {
      throw UrlCouldNotBeOpenedException("The url $url could not be opened");
    }
  }
}

enum LaunchMode {
  /// Leaves the decision of how to launch the URL to the platform
  /// implementation.
  platformDefault,

  /// Loads the URL in an in-app web view (e.g., Safari View Controller).
  inAppWebView,

  /// Passes the URL to the OS to be handled by another application.
  externalApplication,

  /// Passes the URL to the OS to be handled by another non-browser application.
  externalNonBrowserApplication,
}