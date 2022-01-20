import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/services/auth_service.dart';

class JobApplicationService {
  final baseUrl = apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<String> createStudentApplication(int jobOfferId) async {
    User? currUser = await _authService.readUserFromStorage();
    if (currUser != null) {
      var uId = currUser.id;
      var url = Uri.parse(
          '$baseUrl/api/JobApplication?jobOfferId=$jobOfferId&studentId=$uId');
      try {
        final response = await http.post(url, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              "Bearer " + await _authService.getCurrentToken(),
        }).timeout(const Duration(seconds: 15));
        if (response.statusCode == 200) {
          return response.body;
        } else {
          throw Exception('Request failed');
        }
      } on TimeoutException catch (_) {
        throw TimeoutException('Request timeout');
      }
    } else {
      throw Exception('No saved user');
    }
  }
}
