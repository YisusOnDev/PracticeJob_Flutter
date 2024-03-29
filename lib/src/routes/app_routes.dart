import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practicejob/src/guards/auth_guard.dart';
import 'package:practicejob/src/models/joboffer.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/pages/complete_profile_page.dart';
import 'package:practicejob/src/pages/confirmemail_page.dart';
import 'package:practicejob/src/pages/home_page.dart';
import 'package:practicejob/src/pages/jobapplication_page.dart';
import 'package:practicejob/src/pages/jobdetail_page.dart';
import 'package:practicejob/src/pages/joblisting_page.dart';
import 'package:practicejob/src/pages/login_page.dart';
import 'package:practicejob/src/pages/passwordreset_page.dart';
import 'package:practicejob/src/pages/profile_page.dart';
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
    AutoRoute(path: '/resetpassword', page: PasswordResetPage),
    AutoRoute(page: JobDetailPage, guards: [AuthGuard]),

    AutoRoute(path: '/home', page: HomePage, children: [
      RedirectRoute(path: '', redirectTo: 'jobmy'),
      AutoRoute(path: 'jobhome', page: JobListingPage),
      AutoRoute(path: 'jobmy', page: JobApplicationPage),
      AutoRoute(path: 'profile', page: ProfilePage),
      RedirectRoute(path: '*', redirectTo: ''),
    ], guards: [
      AuthGuard
    ]),

    AutoRoute(
      path: '/completeprofile',
      page: CompleteProfilePage,
      guards: [AuthGuard],
    ),

    AutoRoute(
      path: '/confirmemail',
      page: ConfirmEmailPage,
      guards: [AuthGuard],
    ),

    // Redirect all other paths
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter() : super(authGuard: AuthGuard());
}
