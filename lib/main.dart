import 'package:flutter/material.dart';
import 'package:practicejob/app_theme.dart';
import 'package:practicejob/src/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

final _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = MyAppTheme(isDark: false).themeData;
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      title: 'PracticeJob App',
      theme: ThemeData(
          colorScheme: appTheme.colorScheme,
          fontFamily: 'Nunito',
          highlightColor: appTheme.highlightColor,
          toggleableActiveColor: appTheme.toggleableActiveColor),
    );
  }
}
