import 'dart:async';
import 'dart:io';

import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/joboffer.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/services/auth_service.dart';
import 'package:practicejob/src/services/http_interceptor.dart';

class JobOfferService {
  final baseUrl = apiBaseUrl;
  final AuthService _authService = AuthService();
  final authHttp = AuthHttpClient();

  Future<List<JobOffer>> getAll() async {
    var url = Uri.parse('$baseUrl/api/JobOffer/All');

    try {
      final response = await authHttp.get(url, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      }).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return jobOfferListFromJson(response.body);
      } else {
        throw Exception('Request failed');
      }
    } on TimeoutException catch (_) {
      throw TimeoutException('Request timeout');
    }
  }

  Future<List<JobOffer>> getAllAvailableFromFp() async {
    User? currUser = await _authService.readUserFromStorage();
    if (currUser != null) {
      var fpId = currUser.fpId;
      var url =
          Uri.parse('$baseUrl/api/JobOffer/AllAvailableFromFP?fpId=$fpId');
      try {
        final response = await authHttp.get(url, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        }).timeout(const Duration(seconds: 15));
        if (response.statusCode == 200) {
          return jobOfferListFromJson(response.body);
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
