import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myownapp/src/pages/home_page.dart';
import 'package:myownapp/src/pages/signup_page.dart';
import 'package:myownapp/src/pages/welcome_page.dart';

import 'src/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Simple App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
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
      HomePage.pageName: (context) => const HomePage()
    };
  }
}
