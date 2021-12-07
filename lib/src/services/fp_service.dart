import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practicejob/src/models/fp.dart';
import 'package:practicejob/src/services/auth_service.dart';

class FPService {
  final baseUrl = 'http://10.0.2.2:5000';
  final AuthService _authService = AuthService();

  Future<List<FP>> getAll() async {
    var url = Uri.parse('$baseUrl/api/FP/GetAll');

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            "Bearer " + await _authService.getCurrentToken(),
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
