import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/components/profile_image.dart';
import 'package:practicejob/src/models/province.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/models/util.dart';
import 'package:auto_route/auto_route.dart';
import 'package:practicejob/src/services/auth_service.dart';
import 'package:practicejob/src/services/province_service.dart';
import 'package:practicejob/src/services/student_service.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CompleteProfilePage extends StatefulWidget {
  static var pageName = 'CompleteProfilePage';

  const CompleteProfilePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _CompleteProfilePageState createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final StudentService _studentService = StudentService();
  final AuthService _authService = AuthService();
  final ProvinceService _provinceService = ProvinceService();

  final profileForm = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'surname': FormControl<String>(validators: [Validators.required]),
    'birthdate': FormControl<DateTime>(validators: [Validators.required]),
    'province': FormControl<Province>(validators: [Validators.required]),
    'city': FormControl<String>(validators: [Validators.required]),
    //'fplevel': FormControl<String>(validators: [Validators.required]),
    //'fpfamily': FormControl<String>(validators: [Validators.required]),
    //'fpname': FormControl<String>(validators: [Validators.required]),
    //'calification':
    //    FormControl<int>(validators: [Validators.required, Validators.number]),
  });

  String _imagePath = "https://i.imgur.com/NEYyj2d.png";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete your profile'),
        toolbarHeight: size.height / 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(size.width, 29.0),
          ),
        ),
        backgroundColor: cPrimaryColor,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 0),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              ProfileWidget(
                imagePath: _imagePath,
                onClicked: () async {
                  final XFile? image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _imagePath = image.path;
                    });
                  } else {
                    Util.showMyDialog(
                        context, "Error", "Please, select an image.");
                  }
                },
              ),
              buildCompleteProfileForm(),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCompleteProfileForm() {
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
            FutureBuilder(
              future: _provinceService.getAll(),
              initialData: const [],
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ReactiveDropdownField<Province>(
                    formControlName: 'province',
                    decoration: formDecoration(
                        const Icon(
                          Icons.location_city_rounded,
                          color: cPrimaryColor,
                        ),
                        'Province'),
                    items: getProvinceList(snapshot.data),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
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
            /*ReactiveDropdownField<String>(
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
              items: getFpLevelList(),
            ),
            ReactiveDropdownField<String>(
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
              items: getFpGradeList(),
            ),
            ReactiveDropdownField<String>(
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
              items: getFpNameList(),
            ),
            ReactiveTextField(
              keyboardType: TextInputType.number,
              formControlName: 'calification',
              validationMessages: (control) => {
                'number': 'Calification must be a number',
                'required':
                    'The calification field must not be empty and must be a number',
              },
              decoration: formDecoration(
                  const Icon(
                    Icons.expand_more,
                    color: cPrimaryColor,
                  ),
                  'Calification'),
            ),*/
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

  List<DropdownMenuItem<Province>> getProvinceList(data) {
    final List<DropdownMenuItem<Province>> provinceList = [];
    for (Province p in data) {
      provinceList.add(DropdownMenuItem(child: Text(p.name), value: p));
    }
    return provinceList;
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

  doTrySaveProfile() async {
    if (profileForm.valid) {
      User? user = await _authService.readFromStorage();
      if (user != null) {
        String name = profileForm.control('name').value;
        String surname = profileForm.control('surname').value;
        DateTime birthdate = profileForm.control('birthdate').value;
        Province province = profileForm.control('province').value;
        int provinceId = province.id; // GetProvinceId selected from array
        String city = profileForm.control('city').value;
        // String fplevel = profileForm.control('fplevel').value;
        // String fpfamily = profileForm.control('fpfamily').value;
        // String fpname = profileForm.control('fpname').value;
        // int calification = profileForm.control('calification').value;

        user.name = name;
        user.lastname = surname;
        user.birthdate = birthdate;
        user.province = province;
        user.provinceId = provinceId;
        user.city = city;

        try {
          final res = await _studentService.update(user.toJson());
          if (res.statusCode == 200) {
            await _authService.saveDataToStorage(res.body);
            context.router.replaceNamed('/home');
          } else {
            Util.showMyDialog(context, "Error",
                "Your profile couldn't be saved, if this happens again contact an Administrator.");
          }
        } on TimeoutException catch (_) {
          Util.showMyDialog(
              context, "Error", "An error has occurred, please try again.");
        }
      } else {
        Util.showMyDialog(context, "Error", "Your session has expired.");
        context.router.replaceNamed('/');
      }
    }
  }
}
