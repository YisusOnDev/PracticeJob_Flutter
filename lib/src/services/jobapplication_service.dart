import 'dart:async';
import 'dart:io';

import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/services/auth_service.dart';
import 'package:practicejob/src/services/http_interceptor.dart';

class JobApplicationService {
  final AuthService _authService = AuthService();
  final authHttp = AuthHttpClient();

  Future<String> createStudentApplication(int jobOfferId) async {
    User? currUser = await _authService.readUserFromStorage();
    if (currUser != null) {
      var uId = currUser.id;
      var url = Uri.parse(
          '$serverRoot/api/JobApplication?jobOfferId=$jobOfferId&studentId=$uId');
      try {
        final response = await authHttp.post(url, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        }).timeout(const Duration(seconds: 30));
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

  Future<bool> deleteStudentApplication(int jobApplicationId) async {
    var url = Uri.parse(
        '$serverRoot/api/JobApplication?applicationId=$jobApplicationId');
    try {
      final response = await authHttp.delete(url, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      }).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        return response.body == 'true';
      } else {
        throw Exception('Request failed');
      }
    } on TimeoutException catch (_) {
      throw TimeoutException('Request timeout');
    }
  }
}
