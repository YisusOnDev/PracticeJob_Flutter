import 'dart:async';
import 'dart:io';

import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/fp.dart';
import 'package:practicejob/src/services/http_interceptor.dart';

class FPService {
  final baseUrl = apiBaseUrl;
  final authHttp = AuthHttpClient();

  Future<List<FP>> getAll() async {
    var url = Uri.parse('$baseUrl/api/FP/All');

    try {
      final response = await authHttp.get(url, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      }).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return fpListFromJson(response.body);
      } else {
        throw Exception('Request failed');
      }
    } on TimeoutException catch (_) {
      throw TimeoutException('Request timeout');
    }
  }
}
