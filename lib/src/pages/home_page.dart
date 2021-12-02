import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/services/auth_service.dart';

class HomePage extends StatefulWidget {
  static var pageName = 'Home Page';

  const HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextStyle homeTextStyle = const TextStyle(
      height: 5,
      fontSize: 38,
      color: Colors.black,
      backgroundColor: cPrimaryLightColor);
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: cPrimaryColor,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Bienvenido!', style: homeTextStyle),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: cPrimaryColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextButton(
                onPressed: () async {
                  _authService.logout();
                  context.router.replaceNamed('/');
                },
                style: TextButton.styleFrom(primary: Colors.white),
                child: const Text("LOG OUT"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
