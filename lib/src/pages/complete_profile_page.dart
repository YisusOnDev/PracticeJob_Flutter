import 'package:flutter/material.dart';
import 'package:practicejob/constants.dart';
import 'package:practicejob/src/components/profile_image.dart';
import 'package:practicejob/src/pages/home_page.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
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
    'birthdate': FormControl<DateTime>(validators: [Validators.required]),
    'province': FormControl<String>(validators: [Validators.required]),
    'city': FormControl<String>(validators: [Validators.required]),
    'fplevel': FormControl<String>(validators: [Validators.required]),
    'fpfamily': FormControl<String>(validators: [Validators.required]),
    'fpname': FormControl<String>(validators: [Validators.required]),
    'calification':
        FormControl<int>(validators: [Validators.required, Validators.number]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completa tu perfil'),
        backgroundColor: cPrimaryColor,
        elevation: 1,
        automaticallyImplyLeading: false,
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
              buildLoginForm(),
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
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      child: ReactiveForm(
        formGroup: profileForm,
        child: Column(
          children: <Widget>[
            ReactiveTextField(
              formControlName: 'name',
              validationMessages: (control) => {
                'required': 'The name field must not be empty',
              },
              decoration: formDecoration(
                  const Icon(
                    Icons.person,
                    color: cPrimaryColor,
                  ),
                  'Name'),
            ),
            ReactiveTextField(
              formControlName: 'surname',
              validationMessages: (control) => {
                'required': 'The surname field must not be empty',
              },
              decoration: formDecoration(
                  const Icon(
                    Icons.person_add,
                    color: cPrimaryColor,
                  ),
                  'Surname'),
            ),
            ReactiveDateTimePicker(
              formControlName: 'birthdate',
              validationMessages: (control) => {
                'required': 'The birthdate field must not be empty',
              },
              decoration: formDecoration(
                  const Icon(
                    Icons.calendar_today,
                    color: cPrimaryColor,
                  ),
                  'Birthdate'),
            ),
            ReactiveDropdownSearch<String, String>(
              popupBackgroundColor: cPrimaryLightColor,
              formControlName: 'province',
              validationMessages: (control) => {
                'required': 'The province field must not be empty',
              },
              decoration: formDecoration(
                  const Icon(
                    Icons.location_city_rounded,
                    color: cPrimaryColor,
                  ),
                  'Province'),
              mode: Mode.MENU,
              showSelectedItems: true,
              items: getProvinceList(),
              showClearButton: true,
            ),
            ReactiveTextField(
              formControlName: 'city',
              validationMessages: (control) => {
                'required': 'The city field must not be empty',
              },
              decoration: formDecoration(
                  const Icon(
                    Icons.apartment,
                    color: cPrimaryColor,
                  ),
                  'City'),
            ),
            ReactiveDropdownSearch<String, String>(
              popupBackgroundColor: cPrimaryLightColor,
              formControlName: 'fplevel',
              validationMessages: (control) => {
                'required': 'The FP Level field must not be empty',
              },
              decoration: formDecoration(
                  const Icon(
                    Icons.location_city_rounded,
                    color: cPrimaryColor,
                  ),
                  'FP Level'),
              mode: Mode.MENU,
              showSelectedItems: true,
              items: getFpLevelList(),
              showClearButton: true,
            ),
            ReactiveDropdownSearch<String, String>(
              popupBackgroundColor: cPrimaryLightColor,
              formControlName: 'fpfamily',
              validationMessages: (control) => {
                'required': 'The FP Family field must not be empty',
              },
              decoration: formDecoration(
                  const Icon(
                    Icons.location_city_rounded,
                    color: cPrimaryColor,
                  ),
                  'FP Family'),
              mode: Mode.MENU,
              showSelectedItems: true,
              items: getFpGradeList(),
              showClearButton: true,
            ),
            ReactiveDropdownSearch<String, String>(
              popupBackgroundColor: cPrimaryLightColor,
              formControlName: 'fpname',
              validationMessages: (control) => {
                'required': 'The FP Name field must not be empty',
              },
              decoration: formDecoration(
                  const Icon(
                    Icons.location_city_rounded,
                    color: cPrimaryColor,
                  ),
                  'FP Name'),
              mode: Mode.MENU,
              showSelectedItems: true,
              items: getFpNameList(),
              showClearButton: true,
            ),
            ReactiveTextField(
              formControlName: 'calification',
              validationMessages: (control) => {
                'required': 'The calification field must not be empty',
                'number': 'Calification must be a number',
              },
              decoration: formDecoration(
                  const Icon(
                    Icons.expand_more,
                    color: cPrimaryColor,
                  ),
                  'Calification'),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ElevatedButton(
                onPressed: () => doTrySaveProfile(),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(size.height, 50),
                  primary: cPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29.0),
                  ),
                ),
                child: const Text('Save profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration formDecoration(Icon icon, label) {
    return InputDecoration(
        constraints: const BoxConstraints(minHeight: 60),
        prefixIcon: icon,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(29.0)),
          borderSide: BorderSide(color: cPrimaryColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(29.0)),
          borderSide: BorderSide(color: cPrimaryColor),
        ),
        focusColor: cPrimaryColor,
        fillColor: cPrimaryColor,
        hoverColor: cPrimaryColor,
        contentPadding: const EdgeInsets.only(bottom: 0),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ));
  }

  getProvinceList() {
    return ['Málaga', 'Madrid', 'Zaragoza'];
  }

  getFpLevelList() {
    return ['CGB', 'CGM', 'CGS', 'FPS'];
  }

  getFpGradeList() {
    return ['Informática', 'Diseño Gráfico', 'Gestión Empresarial'];
  }

  getFpNameList() {
    return ['SMR', 'DAM', 'DAW'];
  }

  doTrySaveProfile() {
    if (profileForm.valid) {
      // Update to DB and Update SecureStorage
      Navigator.pushNamed(context, HomePage.pageName);
    }
  }
}
