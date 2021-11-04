import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practicejob/constants.dart';
import 'package:practicejob/src/components/rounded_input_field.dart';
import 'package:practicejob/src/components/rounded_password_field.dart';
import 'package:practicejob/src/pages/home_page.dart';
import 'package:practicejob/src/pages/signup_page.dart';
import 'package:practicejob/src/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  static var pageName = 'Login';

  final String? title;
  const LoginPage({Key? key, this.title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              "assets/images/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.25,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "Your Email",
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
                      final res = await _auth.login(_email, _password);
                      final data = jsonDecode(res) as Map<String, dynamic>;
                      if (data['status'] != 200) {
                        print("FAIL");
                      } else {
                        print("OK");
                        Navigator.pushNamed(context, HomePage.pageName);
                      }
                    },
                    style: TextButton.styleFrom(primary: Colors.white),
                    child: const Text("LOGIN"),
                  ),
                ),
                TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, SignUpPage.pageName),
                    style: TextButton.styleFrom(primary: cPrimaryColor),
                    child: const Text("Don’t have an Account?")),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
