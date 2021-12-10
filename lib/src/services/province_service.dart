import 'dart:async';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practicejob/src/models/province.dart';
import 'package:practicejob/src/services/auth_service.dart';

class ProvinceService {
  final baseUrl = 'http://10.0.2.2:5000';
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
        _authService.getFirstPageRoute();
        throw Exception('Session expired');
      } else {
        throw Exception('Request failed');
      }
    } on TimeoutException catch (_) {
      throw TimeoutException('Request timeout');
    }
  }
}
