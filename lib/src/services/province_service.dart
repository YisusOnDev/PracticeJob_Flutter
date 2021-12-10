import 'dart:async';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/province.dart';
import 'package:practicejob/src/services/auth_service.dart';

class ProvinceService {
  final baseUrl = apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<List<Province>> getAll() async {
    var url = Uri.parse('$baseUrl/api/Province/GetAll');

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            "Bearer " + await _authService.getCurrentToken(),
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
