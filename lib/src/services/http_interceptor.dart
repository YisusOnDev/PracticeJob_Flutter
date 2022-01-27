import 'package:http/http.dart' as http;
import 'package:practicejob/src/services/auth_service.dart';

class AuthHttpClient extends http.BaseClient {
  final AuthService authService = AuthService();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = 'Bearer ' + await authService.getCurrentToken();
    if (token.isNotEmpty) {
      request.headers.putIfAbsent('Authorization', () => token);
    }

    return request.send();
  }
}
