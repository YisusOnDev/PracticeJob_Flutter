import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/app_utils.dart';
import 'package:practicejob/src/components/text_field_container.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/services/auth_service.dart';
import 'package:practicejob/src/services/student_service.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ConfirmEmailPage extends StatefulWidget {
  static var pageName = 'Login';

  final String? title;
  const ConfirmEmailPage({Key? key, this.title}) : super(key: key);

  @override
  _ConfirmEmailPageState createState() => _ConfirmEmailPageState();
}

class _ConfirmEmailPageState extends State<ConfirmEmailPage> {
  final AuthService _authService = AuthService();
  final StudentService _studentService = StudentService();

  final confirmEmailForm = FormGroup({
    'code': FormControl<String>(validators: [
      Validators.required,
      Validators.number,
    ]),
  });

  @override
  initState() {
    super.initState();
    Util.showNotification(
        "Te hemos envíado un código de confirmación a tu email, úsalo para confirmar tu cuenta",
        "info");
  }

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
                  "CONFIRMACIÓN DE EMAIL",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: cPrimaryColor),
                ),
                SizedBox(height: size.height * 0.03),
                buildCodeForm(),
                TextButton(
                    onPressed: () => resendConfirmEmail(),
                    style: TextButton.styleFrom(primary: cPrimaryColor),
                    child: const Text("Reenviar código de confirmación")),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget buildCodeForm() {
    Size size = MediaQuery.of(context).size;
    return ReactiveForm(
      formGroup: confirmEmailForm,
      child: Column(
        children: <Widget>[
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
                if (confirmEmailForm.valid) {
                  doConfirmEmail();
                }
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: const Text("CONFIRMAR CUENTA"),
            ),
          ),
        ],
      ),
    );
  }

  resendConfirmEmail() async {
    Util.noInteractLoading();
    try {
      User? user = await _authService.readUserFromStorage();
      final res = await _studentService.resendConfirmEmail(user!.toJson());
      if (res.statusCode == 200) {
        Util.showNotification("Código de confirmación reenviado.", "info");
      } else {
        Util.showNotification("Tu sesión ha caducado", 'error');
        context.router.removeLast();
        context.router.replaceNamed('/welcome');
      }
    } on TimeoutException catch (_) {
      Util.showNotification(
          "Ha ocurrido un error, por favor, intentelo más tarde.", "error");
    } finally {
      Util.dismissLoading();
    }
  }

  doConfirmEmail() async {
    Util.noInteractLoading();
    String _code = confirmEmailForm.control('code').value;
    try {
      User? user = await _authService.readUserFromStorage();
      final res = await _studentService.validateEmail(user!.toJson(), _code);
      if (res.statusCode == 200) {
        await _authService.saveUserToStorage(res.body);
        user = await _authService.readUserFromStorage();
        if (user!.validatedEmail == true) {
          var routeToGo = await _authService.getFirstPageRoute();
          context.router.removeLast();
          context.router.replaceNamed(routeToGo);
        } else {
          Util.showNotification("El código introducido no es válido", 'error');
        }
      } else {
        Util.showNotification("Tu tiempo de confirmación ha expirado", 'error');
        context.router.removeLast();
        context.router.replaceNamed('/welcome');
      }
    } on TimeoutException catch (_) {
      Util.showNotification(
          "Ha ocurrido un error, por favor, intentelo más tarde.", "error");
    } finally {
      Util.dismissLoading();
    }
  }
}
