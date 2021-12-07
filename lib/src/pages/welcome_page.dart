import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/services/auth_service.dart';

final AuthService _authService = AuthService();

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: userCompletedProfile(),
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          String result = snapshot.data;
          if (result == 'home') {
            context.router.replaceNamed('/home');
          } else if (result == 'completeprofile') {
            context.router.replaceNamed('/completeprofile');
          }
        }
        return buildWelcomePage(context);
      },
    );
  }

  Widget buildWelcomePage(context) {
    Size size = MediaQuery.of(context).size;
    final router = AutoRouter.of(context);
    return Scaffold(
      body: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width * 0.2,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "WELCOME TO PRACTICEJOB",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: size.height * 0.05),
                  SvgPicture.asset(
                    "assets/icons/chat.svg",
                    height: size.height * 0.45,
                  ),
                  SizedBox(height: size.height * 0.05),
                  ElevatedButton(
                      onPressed: () => router.pushNamed('/login'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width * 0.5, 25),
                        primary: cPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29.0),
                        ),
                      ),
                      child: const Text('LOG IN')),
                  ElevatedButton(
                      onPressed: () => router.pushNamed('/signup'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width * 0.5, 25),
                        primary: cPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29.0),
                        ),
                      ),
                      child: const Text('CREATE ACCOUNT')),
                ],
              ),
            ),
          ])),
    );
  }
}

Future<String> userCompletedProfile() async {
  User? u = await _authService.readFromStorage();
  bool authenticated = await _authService.isAuthenticated();
  if (authenticated == true) {
    if (u != null && u.token != null) {
      if (u.name != null) {
        return 'home';
      } else {
        return 'completeprofile';
      }
    }
  }
  return 'needlogin';
}
