import 'dart:convert';

import 'package:powasys_frontend/bloc/providers/http_data_provider.dart';
import 'package:powasys_frontend/constants.dart';

class DataRepo {
  final _httpDataProvider = HttpDataProvider();

  Future<dynamic> getPowas() async =>
      getJson(Uri.parse('$apiBaseUrl$apiEndpointPowas'));

  Future<dynamic> get24h({required int minDiv}) async =>
      getJson(Uri.parse('$apiBaseUrl$apiEndpoint24h?minDiv=$minDiv'));

  Future<dynamic> getJson(Uri uri) async =>
      json.decode(await _httpDataProvider.getBody(uri));
}
