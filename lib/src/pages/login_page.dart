import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/components/text_field_container.dart';
import 'package:practicejob/app_utils.dart';
import 'package:auto_route/auto_route.dart';
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
                  "INICIO DE SESIÓN",
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
                    onPressed: () => context.router.pushNamed('/signup'),
                    style: TextButton.styleFrom(primary: cPrimaryColor),
                    child: const Text("¿No tienes cuenta aún?")),
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
                'required': 'El correo no puede estar vacío',
                'email': 'El correo debe ser válido'
              },
              decoration:
                  Util.formDecoration(Icons.person, 'Correo electrónico'),
            ),
          ),
          TextFieldContainer(
            child: ReactiveTextField(
              formControlName: 'password',
              obscureText: true,
              validationMessages: (control) => {
                'required': 'La contraseña no puede estar vacía',
              },
              decoration: Util.formDecoration(Icons.lock, 'Contraseña'),
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
              child: const Text("INICIAR SESIÓN"),
            ),
          ),
        ],
      ),
    );
  }

  doLogin() async {
    Util.noInteractLoading();
    String _email = loginForm.control('email').value;
    String _password = loginForm.control('password').value;
    try {
      final res = await _authService.login(_email, _password);
      if (res.statusCode == 200) {
        await _authService.saveTokenToStorage(res.headers['authorization']);
        await _authService.saveUserToStorage(res.body);

        if (jsonDecode(res.body)['name'] == null) {
          context.router.removeLast();
          context.router.replaceNamed('/completeprofile');
        } else {
          context.router.removeLast();
          context.router.replaceNamed('/home');
        }
      } else {
        Util.showNotification("Credenciales inválidas.", "error");
      }
    } on TimeoutException catch (_) {
      Util.showNotification(
          "Ha ocurrido un error, por favor, intentelo más tarde.", "error");
    } finally {
      Util.dismissLoading();
    }
  }
}
