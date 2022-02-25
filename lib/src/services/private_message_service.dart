import 'dart:async';
import 'dart:io';

import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/private_message.dart';
import 'package:practicejob/src/services/http_interceptor.dart';

class PrivateMessageService {
  final authHttp = AuthHttpClient();

  Future<List<PrivateMessage>> getAllUnread(int studentId) async {
    var url = Uri.parse(
        '$serverRoot/api/PrivateMessage/AllUnread?studentId=$studentId');

    try {
      final response = await authHttp.get(url, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      }).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        return privateMessageListFromJson(response.body);
      } else {
        throw Exception('Request failed');
      }
    } on TimeoutException catch (_) {
      throw TimeoutException('Request timeout');
    }
  }

  Future<bool> setAsRead(int pmId) async {
    var url = Uri.parse('$serverRoot/api/PrivateMessage/SetRead?pmId=$pmId');
    try {
      final response = await authHttp.post(url, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      }).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        return (response.body == 'true');
      } else {
        throw Exception('Request failed');
      }
    } on TimeoutException catch (_) {
      throw TimeoutException('Request timeout');
    }
  }
}
