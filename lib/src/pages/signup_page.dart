import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practicejob/constants.dart';
import 'package:practicejob/src/components/rounded_input_field.dart';
import 'package:practicejob/src/components/rounded_password_field.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/pages/home_page.dart';
import 'package:practicejob/src/pages/login_page.dart';
import 'package:practicejob/src/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  static var pageName = 'SignUp';

  const SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _auth = AuthService();
  String _email = "";
  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/signup_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width * 0.25,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "SIGNUP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/signup.svg",
                    height: size.height * 0.35,
                  ),
                  RoundedInputField(
                    hintText: "Username",
                    onChanged: (value) {
                      _username = value;
                    },
                  ),
                  RoundedInputField(
                    hintText: "Email",
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  Container(
                    // sign up button with nice size
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: cPrimaryColor,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        final res = await _auth
                            .register(User(null, _username, _email, _password));
                        if (res.statusCode != 200) {
                          print("FAIL");
                        } else {
                          print("OK");
                          Navigator.pushNamed(context, HomePage.pageName);
                        }
                      },
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: const Text("SIGN UP"),
                    ),
                  ),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, LoginPage.pageName),
                      style: TextButton.styleFrom(primary: cPrimaryColor),
                      child: const Text("Already have an account?")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
