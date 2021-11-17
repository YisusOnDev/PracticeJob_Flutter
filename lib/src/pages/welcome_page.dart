import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practicejob/constants.dart';
import 'package:practicejob/src/pages/login_page.dart';
import 'package:practicejob/src/pages/signup_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    "BIENVENID@ A PRACTICEJOB",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: size.height * 0.05),
                  SvgPicture.asset(
                    "assets/icons/chat.svg",
                    height: size.height * 0.45,
                  ),
                  SizedBox(height: size.height * 0.05),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, LoginPage.pageName),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width * 0.5, 25),
                        primary: cPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29.0),
                        ),
                      ),
                      child: const Text('INICIAR SESIÓN')),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, SignUpPage.pageName),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width * 0.5, 25),
                        primary: cPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29.0),
                        ),
                      ),
                      child: const Text('CREAR CUENTA')),
                ],
              ),
            ),
          ])),
    );
  }
}
