import 'package:flutter/material.dart';
import 'package:practicejob/constants.dart';
import 'package:practicejob/src/components/profile_image.dart';
import 'package:practicejob/src/pages/home_page.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CompleteProfilePage extends StatefulWidget {
  static var pageName = 'CompleteProfilePage';

  const CompleteProfilePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _CompleteProfilePageState createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  bool showPassword = false;
  final profileForm = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'surname': FormControl<String>(validators: [Validators.required]),
    'birthdate': FormControl<String>(validators: [Validators.required]),
    'province': FormControl<String>(validators: [Validators.required]),
    'city': FormControl<String>(validators: [Validators.required]),
    'fplevel': FormControl<String>(validators: [Validators.required]),
    'fpgrade': FormControl<String>(validators: [Validators.required]),
    'fpname': FormControl<String>(validators: [Validators.required]),
    'calification': FormControl<String>(
        validators: [Validators.required, Validators.number]),
  });

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
              buildTextField("Name", ""),
              buildTextField("Surnames", ""),
              buildTextField("Birthdate", ""),
              buildTextField("Province #", ""),
              buildTextField("City", ""),
              buildTextField("FP Level #", ""),
              buildTextField("FP Grade Type #", ""),
              buildTextField("FP Name #", ""),
              buildTextField("Calification #", ""),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, HomePage.pageName),
                  style: ElevatedButton.styleFrom(
                    primary: cPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29.0),
                    ),
                  ),
                  child: const Text('Save profile')),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm() {
    return ReactiveForm(
      formGroup: profileForm,
      child: Column(
        children: <Widget>[
          // HERE REACTIVE FORM AND HIS FIELDS
        ],
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: TextFormField(
        decoration: InputDecoration(
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
