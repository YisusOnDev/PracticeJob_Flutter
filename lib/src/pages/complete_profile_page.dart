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
import 'package:practicejob/app_utils.dart';
import 'package:practicejob/src/services/auth_service.dart';
import 'package:practicejob/src/services/fp_service.dart';
import 'package:practicejob/src/services/province_service.dart';
import 'package:practicejob/src/services/student_service.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CompleteProfilePage extends StatefulWidget {
  static var pageName = 'CompleteProfilePage';

  const CompleteProfilePage({Key? key, this.title, this.userData, fromSettings})
      : super(key: key);

  final String? title;
  final User? userData;

  @override
  _CompleteProfilePageState createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  _CompleteProfilePageState();

  final StudentService _studentService = StudentService();
  final AuthService _authService = AuthService();
  final ProvinceService _provinceService = ProvinceService();
  final FPService _fpService = FPService();

  List<dynamic> fpList = [];

  final profileForm = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'surname': FormControl<String>(validators: [Validators.required]),
    'birthdate': FormControl<DateTime>(
        validators: [Validators.required, Util.is16YearsOldValidator()]),
    'province': FormControl<Province>(validators: [Validators.required]),
    'city': FormControl<String>(validators: [Validators.required]),
    'fpgrade': FormControl<FPGrade>(validators: [Validators.required]),
    'fpfamily': FormControl<FPFamily>(validators: [Validators.required]),
    'fpname': FormControl<FP>(validators: [Validators.required]),
    'calification': FormControl<double>(
      validators: [
        Validators.required,
        Validators.min(5.0),
        Validators.max(10.0)
      ],
    )
  });

  String _imagePath = "https://i.imgur.com/NEYyj2d.png";

  @override
  initState() {
    super.initState();
    _fillForm(widget.userData);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(widget.title)),
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
                        context, "Error", "Por favor, selecciona una imagen");
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

  _getAppBarTitle(title) {
    if (title != null) {
      return title;
    } else {
      return 'Completa tu perfil';
    }
  }

  _fillForm(user) {
    profileForm.control('name').updateValue(user.name);
    profileForm.control('surname').updateValue(user.lastName);
    profileForm.control('birthdate').updateValue(user.birthDate);
    profileForm.control('province').updateValue(user.province);
    profileForm.control('city').updateValue(user.city);
    profileForm.control('fpgrade').updateValue(user.fp?.fpGrade);
    profileForm.control('fpfamily').updateValue(user.fp?.fpFamily);
    profileForm.control('fpname').updateValue(user.fp);
    profileForm.control('calification').updateValue(user.fpCalification);
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
                        'required': 'El nombre no puede estar vacio',
                      },
                      decoration: Util.formDecoration(Icons.person, 'Nombre'),
                    ),
                  ),
                  TextFieldContainer(
                      child: ReactiveTextField(
                    formControlName: 'surname',
                    validationMessages: (control) => {
                      'required': 'Los apellidos no pueden estar vacios',
                    },
                    decoration:
                        Util.formDecoration(Icons.person_add, 'Apellidos'),
                  )),
                  TextFieldContainer(
                      child: ReactiveDateTimePicker(
                    lastDate: DateTime.now(),
                    formControlName: 'birthdate',
                    validationMessages: (control) => {
                      'required': 'La fecha de nacimiento no puede estar vacía',
                      'minAge': 'Tienes que tener 16 años como mínimo'
                    },
                    decoration:
                        Util.formDecoration(Icons.cake, 'Fecha de nacimiento'),
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
                            'required': 'La provincia no puede estar vacía',
                          },
                          decoration: Util.formDecoration(
                              Icons.location_city_rounded, 'Provincia'),
                          items: getProvinceList(snapshot.data),
                        ));
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  TextFieldContainer(
                      child: ReactiveTextField(
                    formControlName: 'city',
                    validationMessages: (control) => {
                      'required': 'La ciudad no puede estar vacía',
                    },
                    decoration: Util.formDecoration(Icons.apartment, 'Ciudad'),
                  )),

                  TextFieldContainer(
                      child: ReactiveDropdownField<FPGrade>(
                    formControlName: 'fpgrade',
                    isExpanded: true,
                    validationMessages: (control) => {
                      'required': 'El grado no puede estar vacío',
                    },
                    decoration: Util.formDecoration(
                      Icons.grade,
                      'Grado (FP)',
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
                          'required': 'La familia no puede estar vacía',
                        },
                        decoration: Util.formDecoration(
                          Icons.history_edu,
                          'Familia (FP)',
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
                          'required': 'El título no puede estar vacío',
                        },
                        decoration: Util.formDecoration(
                          Icons.school,
                          'Título (FP)',
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
                      'required': 'La nota media no puede estar vacía',
                      'min': 'El mínimo es 5',
                      'max': 'El máximo es 10',
                    },
                    decoration: Util.formDecoration(
                      Icons.format_list_numbered,
                      'Nota media (FP)',
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
                      child: const Text("GUARDAR PERFIL"),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          //return const CircularProgressIndicator();
          return Util.showLoadingDialog();
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
                "Tu perfil no se ha podido guardar correctamente, si el error persiste contacte con un Administrador.");
          }
        } on TimeoutException catch (_) {
          Util.showMyDialog(context, "Error",
              "Ha ocurrido un error, por favor, intentelo de nuevo más tarde.");
        }
      } else {
        Util.showMyDialog(context, "Error", "Tu sesión ha expirado.");
        context.router.replaceNamed('/');
      }
      Util.rebuildAllChildren(context);
    } else {
      profileForm.markAllAsTouched();
      Util.showMyDialog(
          context, "Error", "Por favor rellena todos los campos requeridos.");
    }
  }
}
