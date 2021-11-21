import 'package:flutter/material.dart';
import 'package:practicejob/constants.dart';
import 'package:practicejob/src/pages/complete_profile_page.dart';
import 'package:practicejob/src/pages/home_page.dart';
import 'package:practicejob/src/pages/login_page.dart';
import 'package:practicejob/src/pages/signup_page.dart';
import 'package:practicejob/src/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PracticeJob App',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: cPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Nunito'),
      initialRoute: '/',
      routes: _generateRoutes(context),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const HomePage());
      },
    );
  }

  Map<String, WidgetBuilder> _generateRoutes(context) {
    return <String, WidgetBuilder>{
      '/': (context) => const WelcomePage(),
      LoginPage.pageName: (context) => const LoginPage(),
      SignUpPage.pageName: (context) => const SignUpPage(),
      HomePage.pageName: (context) => const HomePage(),
      CompleteProfilePage.pageName: (context) => const CompleteProfilePage()
    };
  }
}
