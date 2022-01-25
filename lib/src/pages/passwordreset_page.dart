import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/app_utils.dart';
import 'package:practicejob/src/components/text_field_container.dart';
import 'package:practicejob/src/models/password_reset.dart';
import 'package:practicejob/src/services/student_service.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PasswordResetPage extends StatefulWidget {
  static var pageName = 'Login';

  final String? title;
  const PasswordResetPage({Key? key, this.title}) : super(key: key);

  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final StudentService _studentService = StudentService();

  final passwordResetForm = FormGroup({
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ]),
    'password': FormControl<String>(validators: [
      Validators.required,
    ]),
    'code': FormControl<String>(validators: [
      Validators.required,
      Validators.number,
    ]),
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
                  "REESTABLECIMIENTO DE CONTRASEÑA",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: cPrimaryColor),
                ),
                SizedBox(height: size.height * 0.03),
                buildResetPasswordForm(),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget buildResetPasswordForm() {
    Size size = MediaQuery.of(context).size;
    passwordResetForm.control('password').markAsEnabled();
    passwordResetForm.control('code').markAsEnabled();
    return ReactiveForm(
      formGroup: passwordResetForm,
      child: Column(
        children: <Widget>[
          TextFieldContainer(
            child: ReactiveTextField(
              keyboardType: TextInputType.emailAddress,
              formControlName: 'email',
              validationMessages: (control) => {
                'required': 'El código no puede estar vacío',
                'email': 'Introduce un email válido'
              },
              decoration:
                  Util.formDecoration(Icons.email, 'Correo electrónico'),
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
              onPressed: () => requestCode(),
              style: TextButton.styleFrom(primary: Colors.white),
              child: const Text("SOLICITAR CÓDIGO"),
            ),
          ),
          TextFieldContainer(
            child: ReactiveTextField(
              formControlName: 'password',
              obscureText: true,
              validationMessages: (control) => {
                'required': 'La contraseña no puede estar vacía',
              },
              decoration: Util.formDecoration(Icons.lock, 'Nueva contraseña'),
            ),
          ),
          TextFieldContainer(
            child: ReactiveTextField(
              keyboardType: TextInputType.number,
              formControlName: 'code',
              validationMessages: (control) => {
                'required': 'El código no puede estar vacío',
                'number': 'El código debe ser un número',
              },
              decoration:
                  Util.formDecoration(Icons.pin, 'Código de confirmación'),
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
                if (passwordResetForm.valid) {
                  doUpdatePassword();
                }
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: const Text("REESTABLECER CONTRASEÑA"),
            ),
          ),
        ],
      ),
    );
  }

  requestCode() async {
    if (!passwordResetForm.control('email').valid) {
      passwordResetForm.control('email').markAsTouched();
    } else {
      Util.noInteractLoading();
      String _email = passwordResetForm.control('email').value;
      try {
        final res = await _studentService.sendResetPasswordMail(_email);
        if (res.statusCode == 200) {
          if (res.body == 'true') {
            Util.showNotification("Código de confirmación envíado.", "info");
          } else {
            Util.showNotification(
                "Este correo electrónico no esta asociado a ninguna cuenta.",
                "info");
          }
        }
      } on TimeoutException catch (_) {
        Util.showNotification(
            "Ha ocurrido un error, por favor, intentelo más tarde.", "error");
      } finally {
        Util.dismissLoading();
      }
    }
  }

  doUpdatePassword() async {
    try {
      Util.noInteractLoading();
      String _email = passwordResetForm.control('email').value;
      String _password = passwordResetForm.control('password').value;
      String _code = passwordResetForm.control('code').value;
      var pwdReset =
          PasswordReset(email: _email, password: _password, tfaCode: _code);
      final res = await _studentService.resetPassword(pwdReset.toJson());
      if (res.statusCode == 200) {
        if (res.body == 'true') {
          Util.showNotification(
              "Contraseña reestablecida con éxito", "success");
          context.router.removeLast();
          context.router.replaceNamed('/welcome');
        } else {
          Util.showNotification(
              "No hemos podido reestablecer tu contraseña, verifica los datos insertados",
              "error");
        }
      } else {
        Util.showNotification(
            "Ha ocurrido un error, por favor, intentelo más tarde.", "error");
      }
    } on TimeoutException catch (_) {
      Util.showNotification(
          "Ha ocurrido un error, por favor, intentelo más tarde.", "error");
    } finally {
      Util.dismissLoading();
    }
  }
}
