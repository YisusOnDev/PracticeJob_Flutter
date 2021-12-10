import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Util {
  static Future<void> showMyDialog(context, title, text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(text)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar',
                  style: TextStyle(color: cPrimaryColor, fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showLoadingDialog() {
    return SizedBox(
      child: AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[CircularProgressIndicator()],
          ),
        ),
      ),
    );
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
}
