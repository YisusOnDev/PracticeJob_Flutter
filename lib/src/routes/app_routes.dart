import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practicejob/src/guards/auth_guard.dart';
import 'package:practicejob/src/pages/complete_profile_page.dart';
import 'package:practicejob/src/pages/home_page.dart';
import 'package:practicejob/src/pages/login_page.dart';
import 'package:practicejob/src/pages/signup_page.dart';
import 'package:practicejob/src/pages/welcome_page.dart';

part 'app_routes.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
    AutoRoute(path: '/welcome', page: WelcomePage, initial: true),
    AutoRoute(path: '/login', page: LoginPage),
    AutoRoute(path: '/signup', page: SignUpPage),
    AutoRoute(path: '/home', page: HomePage, guards: [AuthGuard]),

    AutoRoute(
        path: '/completeprofile',
        page: CompleteProfilePage,
        guards: [AuthGuard]),

    // Redirect all other paths
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter() : super(authGuard: AuthGuard());
}
