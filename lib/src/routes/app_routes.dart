import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practicejob/src/guards/auth_guard.dart';
import 'package:practicejob/src/models/joboffer.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/pages/complete_profile_page.dart';
import 'package:practicejob/src/pages/home_page.dart';
import 'package:practicejob/src/pages/jobdetail_page.dart';
import 'package:practicejob/src/pages/joblisting_page.dart';
import 'package:practicejob/src/pages/login_page.dart';
import 'package:practicejob/src/pages/profile_page.dart';
import 'package:practicejob/src/pages/settings_page.dart';
import 'package:practicejob/src/pages/signup_page.dart';
import 'package:practicejob/src/pages/splashscreen_page.dart';
import 'package:practicejob/src/pages/welcome_page.dart';

part 'app_routes.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: SplashScreen, initial: true),
    AutoRoute(path: '/welcome', page: WelcomePage),
    AutoRoute(path: '/login', page: LoginPage),
    AutoRoute(path: '/signup', page: SignUpPage),
    AutoRoute(page: JobDetailPage, guards: [AuthGuard]),

    AutoRoute(path: '/home', page: HomePage, children: [
      RedirectRoute(path: '', redirectTo: 'settings'),
      AutoRoute(path: 'settings', page: SettingsPage),
      AutoRoute(path: 'profile', page: ProfilePage),
      AutoRoute(path: 'jobhome', page: JobListingPage),
      RedirectRoute(path: '*', redirectTo: ''),
    ], guards: [
      AuthGuard
    ]),

    AutoRoute(
      path: '/completeprofile',
      page: CompleteProfilePage,
      guards: [AuthGuard],
    ),

    // Redirect all other paths
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter() : super(authGuard: AuthGuard());
}
