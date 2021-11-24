import 'package:flutter/material.dart';
import 'package:practicejob/constants.dart';
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
              child:
                  const Text('Dismiss', style: TextStyle(color: cPrimaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static ValidatorFunction mustMatch(
      String controlName, String matchingControlName) {
    return (AbstractControl<dynamic> control) {
      final form = control as FormGroup;

      final formControl = form.control(controlName);
      final matchingFormControl = form.control(matchingControlName);

      if (formControl.value != matchingFormControl.value) {
        matchingFormControl.setErrors({'mustMatch': true});

        // force messages to show up as soon as possible
        matchingFormControl.markAsTouched();
      } else {
        matchingFormControl.removeError('mustMatch');
      }

      return null;
    };
  }
}