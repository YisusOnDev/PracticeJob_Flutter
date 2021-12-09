import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Bienvenido!',
          style: TextStyle(
            height: 5,
            fontSize: 38,
            color: Colors.black,
            backgroundColor: cPrimaryLightColor,
          ),
        ),
      ),
    );
  }
}
