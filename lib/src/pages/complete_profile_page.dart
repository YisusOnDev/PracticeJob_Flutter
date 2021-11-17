import 'package:flutter/material.dart';
import 'package:practicejob/constants.dart';
import 'package:practicejob/src/components/profile_image.dart';
import 'package:practicejob/src/pages/home_page.dart';

class CompleteProfilePage extends StatefulWidget {
  static var pageName = 'CompleteProfilePage';

  const CompleteProfilePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _CompleteProfilePageState createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completa tu perfil'),
        backgroundColor: cPrimaryColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: cPrimaryLightColor,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              ProfileWidget(
                imagePath:
                    "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                onClicked: () {},
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField("Nombre", "", false),
              buildTextField("Apellidos", "", false),
              buildTextField("Fecha de nacimiento", "", false),
              buildTextField("Provincia #", "", false),
              buildTextField("Localidad", "", false),
              buildTextField("Familia Profesional (FP) #", "", false),
              buildTextField("Tipo de grado #", "", false),
              buildTextField("Ciclo #", "", false),
              buildTextField("Calificación #", "", false),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, HomePage.pageName),
                  style: ElevatedButton.styleFrom(
                    primary: cPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29.0),
                    ),
                  ),
                  child: const Text('Confirmar')),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: TextFormField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            )),
      ),
    );
  }
}
