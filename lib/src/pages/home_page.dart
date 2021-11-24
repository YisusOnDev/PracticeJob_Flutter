import 'package:flutter/material.dart';
import 'package:practicejob/constants.dart';

class HomePage extends StatefulWidget {
  static var pageName = 'Home Page';

  const HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextStyle homeTextStyle = const TextStyle(
      height: 5,
      fontSize: 38,
      color: Colors.black,
      backgroundColor: cPrimaryLightColor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: cPrimaryColor,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Bienvenido!', style: homeTextStyle),
          ],
        ),
      ),
    );
  }
}
