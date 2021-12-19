import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/components/text_field_container.dart';
import 'package:practicejob/app_utils.dart';
import 'package:practicejob/src/services/auth_service.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpPage extends StatefulWidget {
  static var pageName = 'SignUp';

  const SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();

  final registerForm = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(validators: [Validators.required]),
    'passwordConfirmation': FormControl<String>(),
  }, validators: [
    Validators.required,
    Util.mustMatchValidator('password', 'passwordConfirmation')
  ]);

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
                    "REGISTRO",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/signup.svg",
                    height: size.height * 0.35,
                  ),
                  buildRegisterForm(),
                  TextButton(
                      onPressed: () => context.router.pushNamed('/login'),
                      style: TextButton.styleFrom(primary: cPrimaryColor),
                      child: const Text("¿Ya tienes una cuenta?")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRegisterForm() {
    Size size = MediaQuery.of(context).size;
    return ReactiveForm(
      formGroup: registerForm,
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
              decoration: const InputDecoration(
                hintText: "Correo electrónico",
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
                'required': 'La contraseña no puede estar vacía',
              },
              decoration: const InputDecoration(
                hintText: "Contraseña",
                icon: Icon(
                  Icons.lock,
                  color: cPrimaryColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          TextFieldContainer(
            child: ReactiveTextField(
              formControlName: 'passwordConfirmation',
              obscureText: true,
              validationMessages: (control) => {
                'required': 'La contraseña no puede estar vacía',
                'mustMatch': 'Las contraseñas deben coincidir'
              },
              decoration: const InputDecoration(
                hintText: "Confirmación de contraseña",
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
                if (registerForm.valid) {
                  doRegister();
                }
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: const Text("CREAR CUENTA"),
            ),
          ),
        ],
      ),
    );
  }

  doRegister() async {
    String _email = registerForm.control('email').value;
    String _password = registerForm.control('password').value;
    try {
      final res = await _authService.register(_email, _password);
      if (res.statusCode == 200) {
        await _authService.saveDataToStorage(res.body);
        context.router.removeLast();
        context.router.replaceNamed('/completeprofile');
      } else {
        Util.showMyDialog(context, "Error",
            "Ya existe una cuenta con este correo electrónico.");
      }
    } on TimeoutException catch (_) {
      Util.showMyDialog(context, "Error",
          "Ha ocurrido un error, por favor, intentelo de nuevo más tarde.");
    }
  }
}
