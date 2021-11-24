import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practicejob/constants.dart';
import 'package:practicejob/src/components/text_field_container.dart';
import 'package:practicejob/src/models/util.dart';
import 'package:practicejob/src/pages/complete_profile_page.dart';
import 'package:practicejob/src/pages/login_page.dart';
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
  final AuthService _auth = AuthService();

  final registerForm = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(validators: [Validators.required]),
    'passwordConfirmation': FormControl<String>(),
  }, validators: [
    Validators.required,
    Util.mustMatch('password', 'passwordConfirmation')
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
                    "SIGN UP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/signup.svg",
                    height: size.height * 0.35,
                  ),
                  buildRegisterForm(),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, LoginPage.pageName),
                      style: TextButton.styleFrom(primary: cPrimaryColor),
                      child: const Text("Have an account?")),
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
          TextFieldContainer(
            child: ReactiveTextField(
              formControlName: 'passwordConfirmation',
              obscureText: true,
              validationMessages: (control) => {
                'required': 'The password must not be empty',
                'mustMatch': 'Passwords must match'
              },
              decoration: const InputDecoration(
                hintText: "Password confirmation",
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
              child: const Text("SIGN UP"),
            ),
          ),
        ],
      ),
    );
  }

  doRegister() async {
    String _email = registerForm.control('email').value;
    String _password = registerForm.control('password').value;
    final res = await _auth.register(_email, _password);
    if (res.statusCode == 200) {
      await _auth.saveDataToStorage(res.body);
      Navigator.pushNamed(context, CompleteProfilePage.pageName);
    } else {
      Util.showMyDialog(
          context, "Error", "An error has occurred. Please try again");
    }
  }
}
