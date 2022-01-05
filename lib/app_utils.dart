import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/jobapplication.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Util {
  static showNotification(String msg, String? type) {
    if (type == null) {
      EasyLoading.showInfo(msg);
    } else {
      switch (type) {
        case "ok":
          EasyLoading.showSuccess(msg);
          break;
        case "error":
          EasyLoading.showError(msg);
          break;
        case "info":
          EasyLoading.showInfo(msg);
          break;
        default:
          EasyLoading.showInfo(msg);
          break;
      }
    }
  }

  static noInteractLoading() {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show();
  }

  static dismissLoading() {
    EasyLoading.dismiss();
  }

  static ValidatorFunction mustMatchValidator(
      String controlName, String matchingControlName) {
    return (AbstractControl<dynamic> control) {
      final form = control as FormGroup;

      final formControl = form.control(controlName);
      final matchingFormControl = form.control(matchingControlName);

      if (formControl.value != matchingFormControl.value) {
        matchingFormControl.setErrors({'mustMatch': true});
        matchingFormControl.markAsTouched();
      } else {
        matchingFormControl.removeError('mustMatch');
      }

      return null;
    };
  }

  static ValidatorFunction is16YearsOldValidator() {
    return (AbstractControl<dynamic> control) {
      final FormControl<DateTime> formField = control as FormControl<DateTime>;

      final DateTime? value = formField.value;
      if (value != null) {
        if (getAgeFromDate(value) < 16) {
          formField.setErrors({'minAge': true});
          formField.markAsTouched();
          return {'minAge': true};
        }
      } else {
        return null;
      }
    };
  }

  static InputDecoration formDecoration(IconData icon, label) {
    return InputDecoration(
      labelText: label,
      icon: Icon(icon, color: cPrimaryColor),
      border: InputBorder.none,
    );
  }

  static int getAgeFromDate(DateTime birthdate) {
    DateTime birthDate = birthdate;
    DateTime today = DateTime.now();
    return today.year - birthDate.year;
  }

  static void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  static String getApplicationStatus(
      List<JobApplication> applications, int appId) {
    ApplicationStatus status = ApplicationStatus.pending;
    for (JobApplication app in applications) {
      if (app.id == appId) {
        status = app.applicationStatus;
      }
    }

    switch (status) {
      case ApplicationStatus.pending:
        return "Pendiente";
      case ApplicationStatus.accepted:
        return "Aceptadada";
      case ApplicationStatus.declined:
        return "Declinada";
      default:
        return "Pendiente";
    }
  }
}
