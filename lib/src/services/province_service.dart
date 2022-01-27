import 'dart:async';
import 'dart:io';

import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/province.dart';
import 'package:practicejob/src/services/http_interceptor.dart';

class ProvinceService {
  final baseUrl = apiBaseUrl;
  final authHttp = AuthHttpClient();

  Future<List<Province>> getAll() async {
    var url = Uri.parse('$baseUrl/api/Province/All');

    try {
      final response = await authHttp.get(url, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      }).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return provinceListFromJson(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('UNAUTHORIZED');
      } else {
        throw Exception('BADREQUEST');
      }
    } on TimeoutException catch (_) {
      throw TimeoutException('TIMEOUT');
    }
  }
}
