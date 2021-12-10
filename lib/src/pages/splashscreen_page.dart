import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practicejob/src/services/auth_service.dart';

final AuthService _authService = AuthService();

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: routeToGo(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          context.router.replaceNamed(snapshot.data);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

Future<String> routeToGo() async {
  String authenticated = await _authService.getFirstPageRoute();
  return authenticated;
}
