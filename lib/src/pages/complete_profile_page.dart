import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/components/profile_image.dart';
import 'package:practicejob/src/components/text_field_container.dart';
import 'package:practicejob/src/models/fp.dart';
import 'package:practicejob/src/models/fp_family.dart';
import 'package:practicejob/src/models/fp_grade.dart';
import 'package:practicejob/src/models/province.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/models/util.dart';
import 'package:practicejob/src/services/auth_service.dart';
import 'package:practicejob/src/services/fp_service.dart';
import 'package:practicejob/src/services/province_service.dart';
import 'package:practicejob/src/services/student_service.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CompleteProfilePage extends StatefulWidget {
  static var pageName = 'CompleteProfilePage';

  const CompleteProfilePage({Key? key, this.title, fromSettings})
      : super(key: key);

  final String? title;

  @override
  _CompleteProfilePageState createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final StudentService _studentService = StudentService();
  final AuthService _authService = AuthService();
  final ProvinceService _provinceService = ProvinceService();
  final FPService _fpService = FPService();

  List<dynamic> fpList = [];

  String dropdownValue = 'One';

  final profileForm = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'surname': FormControl<String>(validators: [Validators.required]),
    'birthdate': FormControl<DateTime>(validators: [Validators.required]),
    'province': FormControl<Province>(validators: [Validators.required]),
    'city': FormControl<String>(validators: [Validators.required]),
    'fpgrade': FormControl<FPGrade>(validators: [Validators.required]),
    'fpfamily': FormControl<FPFamily>(validators: [Validators.required]),
    'fpname': FormControl<FP>(validators: [Validators.required]),
    'calification': FormControl<double>(
      validators: [
        Validators.required,
        Validators.min(0.0),
        Validators.max(10.0)
      ],
    )
  });

  String _imagePath = "https://i.imgur.com/NEYyj2d.png";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete your profile'),
        centerTitle: true,
        toolbarHeight: size.height / 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(size.width, 20.0),
          ),
        ),
        backgroundColor: cPrimaryColor,
        elevation: 5,
        automaticallyImplyLeading: false,
        leading: const AutoBackButton(),
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
    return FutureBuilder(
      future: _fpService.getAll(),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          fpList = snapshot.data;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: size.width * 0.8,
            child: ReactiveForm(
              formGroup: profileForm,
              child: Column(
                children: <Widget>[
                  TextFieldContainer(
                    child: ReactiveTextField(
                      formControlName: 'name',
                      validationMessages: (control) => {
                        'required': 'The name field must not be empty',
                      },
                      decoration: Util.formDecoration(Icons.person, 'Surname'),
                    ),
                  ),
                  TextFieldContainer(
                      child: ReactiveTextField(
                    formControlName: 'surname',
                    validationMessages: (control) => {
                      'required': 'The surname field must not be empty',
                    },
                    decoration:
                        Util.formDecoration(Icons.person_add, 'Surname'),
                  )),
                  TextFieldContainer(
                      child: ReactiveDateTimePicker(
                    formControlName: 'birthdate',
                    validationMessages: (control) => {
                      'required': 'The birthdate field must not be empty',
                    },
                    decoration: Util.formDecoration(Icons.cake, 'Birthdate'),
                  )),
                  TextFieldContainer(
                      child: ReactiveTextField(
                    formControlName: 'city',
                    validationMessages: (control) => {
                      'required': 'The city field must not be empty',
                    },
                    decoration: Util.formDecoration(Icons.apartment, 'City'),
                  )),
                  FutureBuilder(
                    future: _provinceService.getAll(),
                    initialData: const [],
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return TextFieldContainer(
                            child: ReactiveDropdownField<Province>(
                          formControlName: 'province',
                          isExpanded: true,
                          validationMessages: (control) => {
                            'required': 'The province field must not be empty',
                          },
                          decoration: Util.formDecoration(
                              Icons.location_city_rounded, 'Province'),
                          items: getProvinceList(snapshot.data),
                        ));
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  TextFieldContainer(
                      child: ReactiveDropdownField<FPGrade>(
                    formControlName: 'fpgrade',
                    isExpanded: true,
                    validationMessages: (control) => {
                      'required': 'The FP Grade field must not be empty',
                    },
                    decoration: Util.formDecoration(
                      Icons.grade,
                      'FP Grade',
                    ),
                    items: getFpGradeList(),
                  )),
                  ReactiveValueListenableBuilder(
                    formControlName: 'fpgrade',
                    builder: (context, amount, child) {
                      return TextFieldContainer(
                          child: ReactiveDropdownField<FPFamily>(
                        formControlName: 'fpfamily',
                        isExpanded: true,
                        validationMessages: (control) => {
                          'required': 'The FP Family field must not be empty',
                        },
                        decoration: Util.formDecoration(
                          Icons.history_edu,
                          'FP Family',
                        ),
                        items: getFpFamilyList(),
                      ));
                    },
                  ),
                  ReactiveValueListenableBuilder(
                    formControlName: 'fpfamily',
                    builder: (context, amount, child) {
                      return TextFieldContainer(
                          child: ReactiveDropdownField<FP>(
                        formControlName: 'fpname',
                        isExpanded: true,
                        validationMessages: (control) => {
                          'required': 'The FP Name field must not be empty',
                        },
                        decoration: Util.formDecoration(
                          Icons.school,
                          'FP Name',
                        ),
                        items: getFpList(),
                      ));
                    },
                  ),
                  TextFieldContainer(
                      child: ReactiveTextField<double>(
                    formControlName: 'calification',
                    keyboardType: TextInputType.number,
                    validationMessages: (control) => {
                      'required': 'The FP Calification field must not be empty',
                      'min':
                          'The FP Calification field must be greater than 0.0',
                      'max': 'The FP Calification field must be less than 10.0',
                    },
                    decoration: Util.formDecoration(
                      Icons.format_list_numbered,
                      'FP Calification (0-10)',
                    ),
                  )),
                  //
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
                      onPressed: () => doTrySaveProfile(),
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: const Text("SAVE PROFILE"),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  List<DropdownMenuItem<Province>> getProvinceList(data) {
    final List<DropdownMenuItem<Province>> provinceList = [];
    for (Province p in data) {
      provinceList.add(DropdownMenuItem(child: Text(p.name), value: p));
    }
    return provinceList;
  }

  List<DropdownMenuItem<FPGrade>> getFpGradeList() {
    final List<DropdownMenuItem<FPGrade>> dropdownGradeList = [];
    final List<FPGrade> gradeList = [];
    for (FP f in fpList) {
      if (!fpGradeItemAlreadyExist(gradeList, f.fpGrade)) {
        gradeList.add(f.fpGrade);
        dropdownGradeList.add(
            DropdownMenuItem(child: Text(f.fpGrade.name), value: f.fpGrade));
      }
    }
    return dropdownGradeList;
  }

  bool fpGradeItemAlreadyExist(gradeList, grade) {
    for (FPGrade f in gradeList) {
      if (f.id == grade.id) {
        return true;
      }
    }
    return false;
  }

  List<DropdownMenuItem<FPFamily>> getFpFamilyList() {
    final FPGrade? gradeFilter = profileForm.control('fpgrade').value;
    final List<DropdownMenuItem<FPFamily>> dropdownFamilyList = [];
    final List<FPFamily> familyList = [];
    if (gradeFilter != null) {
      for (FP f in fpList) {
        if (f.fpGrade.id == gradeFilter.id) {
          if (!fpFamilyItemAlreadyExist(familyList, f.fpFamily)) {
            familyList.add(f.fpFamily);
            dropdownFamilyList.add(DropdownMenuItem(
                child: Text(f.fpFamily.name), value: f.fpFamily));
          }
        }
      }
    }
    return dropdownFamilyList;
  }

  bool fpFamilyItemAlreadyExist(familyList, family) {
    for (FPFamily f in familyList) {
      if (f.id == family.id) {
        return true;
      }
    }
    return false;
  }

  List<DropdownMenuItem<FP>> getFpList() {
    final FPGrade? gradeFilter = profileForm.control('fpgrade').value;
    final FPFamily? familyFilter = profileForm.control('fpfamily').value;
    final List<DropdownMenuItem<FP>> dropdownFpList = [];
    final List<FP> fpFilteredList = [];
    if (familyFilter != null && gradeFilter != null) {
      for (FP f in fpList) {
        if (f.fpGrade.id == gradeFilter.id &&
            f.fpFamily.id == familyFilter.id) {
          if (!fpItemAlreadyExist(fpFilteredList, f)) {
            fpFilteredList.add(f);
            dropdownFpList.add(DropdownMenuItem(child: Text(f.name), value: f));
          }
        }
      }
    }
    return dropdownFpList;
  }

  bool fpItemAlreadyExist(fpFilterList, fp) {
    for (FP f in fpFilterList) {
      if (f.id == fp.id) {
        return true;
      }
    }
    return false;
  }

  doTrySaveProfile() async {
    if (profileForm.valid) {
      User? user = await _authService.readFromStorage();
      if (user != null) {
        String name = profileForm.control('name').value;
        String surname = profileForm.control('surname').value;
        DateTime birthdate = profileForm.control('birthdate').value;
        Province province = profileForm.control('province').value;
        int provinceId = province.id;
        String city = profileForm.control('city').value;
        FP fp = profileForm.control('fpname').value;
        int fpId = fp.id;
        double calification = profileForm.control('calification').value;
        user.name = name;
        user.lastName = surname;
        user.birthDate = birthdate;
        user.provinceId = provinceId;
        user.province = province;
        user.city = city;
        user.fpId = fpId;
        user.fp = fp;
        user.fpCalification = calification;

        try {
          final res = await _studentService.update(user.toJson());
          if (res.statusCode == 200) {
            await _authService.saveDataToStorage(res.body);
            context.router.removeLast();
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
