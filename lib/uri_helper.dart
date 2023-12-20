/// @author    Diego
/// @since     2022-12-14

class UriHelpers {
  static Uri uriWithQueryParams({
    required String endpointString,
    required Map<String, dynamic> queryParams,
  }) {
    Uri endpoint = Uri.parse(endpointString);
    return endpoint.replace(queryParameters: queryParams);
  }

  static Uri uriWithQueryString({
    required String endpointString,
    required String queryString,
  }) {
    Uri endpoint = Uri.parse(endpointString);
    return endpoint.replace(query: queryString);
  }
}
