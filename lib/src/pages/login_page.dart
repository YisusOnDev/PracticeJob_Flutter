import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practicejob/constants.dart';
import 'package:practicejob/src/components/text_field_container.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/models/util.dart';
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
  final _pwdController = TextEditingController();
  final _emailController = TextEditingController();
  bool _pwdValidate = false;
  bool _emailValidate = false;
  String _email = "";
  String _password = "";

  @override
  void dispose() {
    _pwdController.dispose();
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
                  "INICIO DE SESIÓN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
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
                      hintText: "Contraseña",
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
                Container(
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
                          final res =
                              await _auth.login(User(null, _email, _password));
                          if (res.statusCode == 200) {
                            Navigator.pushNamed(context, HomePage.pageName);
                          } else {
                            Util.showMyDialog(
                                context, "Error", "Invalid credentials.");
                          }
                        } else {
                          Util.showMyDialog(
                              context, "Error", "Please insert a valid email.");
                        }
                      }
                    },
                    style: TextButton.styleFrom(primary: Colors.white),
                    child: const Text("INICIAR SESIÓN"),
                  ),
                ),
                TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, SignUpPage.pageName),
                    style: TextButton.styleFrom(primary: cPrimaryColor),
                    child: const Text("¿No tienes cuenta aún?")),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
