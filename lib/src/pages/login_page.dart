import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practicejob/constants.dart';
import 'package:practicejob/src/components/text_field_container.dart';
import 'package:practicejob/src/models/util.dart';
import 'package:practicejob/src/pages/complete_profile_page.dart';
import 'package:practicejob/src/pages/home_page.dart';
import 'package:practicejob/src/pages/signup_page.dart';
import 'package:practicejob/src/services/auth_service.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatefulWidget {
  static var pageName = 'Login';

  final String? title;
  const LoginPage({Key? key, this.title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();

  final loginForm = FormGroup({
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  @override
  void dispose() {
    super.dispose();
  }

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
                  "LOG IN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: cPrimaryColor),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                buildLoginForm(),
                TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, SignUpPage.pageName),
                    style: TextButton.styleFrom(primary: cPrimaryColor),
                    child: const Text("Don't have an account yet?")),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget buildLoginForm() {
    Size size = MediaQuery.of(context).size;
    return ReactiveForm(
      formGroup: loginForm,
      child: Column(
        children: <Widget>[
          TextFieldContainer(
            child: ReactiveTextField(
              keyboardType: TextInputType.emailAddress,
              formControlName: 'email',
              validationMessages: (control) => {
                'required': 'The email must not be empty',
                'email': 'The email value must be a valid email'
              },
              decoration: const InputDecoration(
                hintText: "Email",
                icon: Icon(
                  Icons.person,
                  color: cPrimaryColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          TextFieldContainer(
            child: ReactiveTextField(
              formControlName: 'password',
              obscureText: true,
              validationMessages: (control) => {
                'required': 'The password must not be empty',
              },
              decoration: const InputDecoration(
                hintText: "Password",
                icon: Icon(
                  Icons.lock,
                  color: cPrimaryColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: size.width * 0.8,
            decoration: BoxDecoration(
              color: cPrimaryColor,
              borderRadius: BorderRadius.circular(29),
            ),
            child: TextButton(
              onPressed: () async {
                if (loginForm.valid) {
                  doLogin();
                }
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: const Text("LOG IN"),
            ),
          ),
        ],
      ),
    );
  }

  doLogin() async {
    String _email = loginForm.control('email').value;
    String _password = loginForm.control('password').value;
    try {
      final res = await _authService.login(_email, _password);
      if (res.statusCode == 200) {
        await _authService.saveDataToStorage(res.body);

        if (jsonDecode(res.body)['data']['name'] == null) {
          Navigator.pushNamed(context, CompleteProfilePage.pageName);
        } else {
          Navigator.pushNamed(context, HomePage.pageName);
        }
      } else {
        Util.showMyDialog(context, "Error", "Invalid credentials.");
      }
    } on TimeoutException catch (_) {
      Util.showMyDialog(
          context, "Error", "An error has occurred, please try again.");
    }
  }
}
