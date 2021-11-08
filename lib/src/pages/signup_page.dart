import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practicejob/constants.dart';
import 'package:practicejob/src/components/text_field_container.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/models/util.dart';
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
  String _password = "";
  String _passwordConfirm = "";

  final _pwdController = TextEditingController();
  final _pwdConfirmController = TextEditingController();
  final _emailController = TextEditingController();
  bool _pwdValidate = false;
  bool _emailValidate = false;

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
                  TextFieldContainer(
                    child: TextField(
                      onChanged: (value) {
                        _email = value;
                      },
                      cursorColor: cPrimaryColor,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        errorText:
                            _emailValidate ? 'Email can\'t be empty' : null,
                        icon: const Icon(
                          Icons.person,
                          color: cPrimaryColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextField(
                      obscureText: true,
                      onChanged: (value) {
                        _password = value;
                      },
                      cursorColor: cPrimaryColor,
                      controller: _pwdController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        errorText:
                            _pwdValidate ? 'Password can\'t be empty' : null,
                        icon: const Icon(
                          Icons.lock,
                          color: cPrimaryColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextField(
                      obscureText: true,
                      onChanged: (value) {
                        _passwordConfirm = value;
                      },
                      cursorColor: cPrimaryColor,
                      controller: _pwdConfirmController,
                      decoration: InputDecoration(
                        hintText: "Password confirmation",
                        errorText: _pwdValidate
                            ? 'Password confirmation can\'t be empty'
                            : null,
                        icon: const Icon(
                          Icons.lock,
                          color: cPrimaryColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
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
                        setState(() {
                          _pwdController.text.isEmpty
                              ? _pwdValidate = true
                              : _pwdValidate = false;
                          _emailController.text.isEmpty
                              ? _emailValidate = true
                              : _emailValidate = false;
                        });

                        if (!_pwdValidate && !_emailValidate) {
                          if (Util.hasEmailFormat(_email)) {
                            if (_password == _passwordConfirm) {
                              final res = await _auth
                                  .register(User(null, _email, _password));
                              if (res.statusCode == 200) {
                                Navigator.pushNamed(context, HomePage.pageName);
                              } else {
                                Util.showMyDialog(context, "Error",
                                    "An error has occurred. Please try again");
                              }
                            } else {
                              Util.showMyDialog(context, "Error",
                                  "Passwords must be the same.");
                            }
                          } else {
                            Util.showMyDialog(context, "Error",
                                "Please insert a valid email.");
                          }
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
