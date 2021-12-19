// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

part of 'app_routes.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter(
      {GlobalKey<NavigatorState>? navigatorKey, required this.authGuard})
      : super(navigatorKey);

  final AuthGuard authGuard;

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const SplashScreen());
    },
    WelcomePageRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomePageRouteArgs>(
          orElse: () => const WelcomePageRouteArgs());
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: WelcomePage(key: args.key, title: args.title));
    },
    LoginPageRoute.name: (routeData) {
      final args = routeData.argsAs<LoginPageRouteArgs>(
          orElse: () => const LoginPageRouteArgs());
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: LoginPage(key: args.key, title: args.title));
    },
    SignUpPageRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpPageRouteArgs>(
          orElse: () => const SignUpPageRouteArgs());
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: SignUpPage(key: args.key, title: args.title));
    },
    JobDetailPageRoute.name: (routeData) {
      final args = routeData.argsAs<JobDetailPageRouteArgs>(
          orElse: () => const JobDetailPageRouteArgs());
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: JobDetailPage(key: args.key, offer: args.offer));
    },
    HomePageRoute.name: (routeData) {
      final args = routeData.argsAs<HomePageRouteArgs>(
          orElse: () => const HomePageRouteArgs());
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: HomePage(key: args.key, title: args.title));
    },
    CompleteProfilePageRoute.name: (routeData) {
      final args = routeData.argsAs<CompleteProfilePageRouteArgs>(
          orElse: () => const CompleteProfilePageRouteArgs());
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: CompleteProfilePage(
              key: args.key,
              title: args.title,
              userData: args.userData,
              fromSettings: args.fromSettings));
    },
    SettingsPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const SettingsPage());
    },
    ProfilePageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const ProfilePage());
    },
    JobListingPageRoute.name: (routeData) {
      final args = routeData.argsAs<JobListingPageRouteArgs>(
          orElse: () => const JobListingPageRouteArgs());
      return AdaptivePage<dynamic>(
          routeData: routeData, child: JobListingPage(key: args.key));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashScreenRoute.name, path: '/'),
        RouteConfig(WelcomePageRoute.name, path: '/welcome'),
        RouteConfig(LoginPageRoute.name, path: '/login'),
        RouteConfig(SignUpPageRoute.name, path: '/signup'),
        RouteConfig(JobDetailPageRoute.name,
            path: '/job-detail-page', guards: [authGuard]),
        RouteConfig(HomePageRoute.name, path: '/home', guards: [
          authGuard
        ], children: [
          RouteConfig('#redirect',
              path: '',
              parent: HomePageRoute.name,
              redirectTo: 'settings',
              fullMatch: true),
          RouteConfig(SettingsPageRoute.name,
              path: 'settings', parent: HomePageRoute.name),
          RouteConfig(ProfilePageRoute.name,
              path: 'profile', parent: HomePageRoute.name),
          RouteConfig(JobListingPageRoute.name,
              path: 'jobhome', parent: HomePageRoute.name),
          RouteConfig('*#redirect',
              path: '*',
              parent: HomePageRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        RouteConfig(CompleteProfilePageRoute.name,
            path: '/completeprofile', guards: [authGuard]),
        RouteConfig('*#redirect', path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for [SplashScreen]
class SplashScreenRoute extends PageRouteInfo<void> {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for [WelcomePage]
class WelcomePageRoute extends PageRouteInfo<WelcomePageRouteArgs> {
  WelcomePageRoute({Key? key, String? title})
      : super(name,
            path: '/welcome',
            args: WelcomePageRouteArgs(key: key, title: title));

  static const String name = 'WelcomePageRoute';
}

class WelcomePageRouteArgs {
  const WelcomePageRouteArgs({this.key, this.title});

  final Key? key;

  final String? title;

  @override
  String toString() {
    return 'WelcomePageRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for [LoginPage]
class LoginPageRoute extends PageRouteInfo<LoginPageRouteArgs> {
  LoginPageRoute({Key? key, String? title})
      : super(name,
            path: '/login', args: LoginPageRouteArgs(key: key, title: title));

  static const String name = 'LoginPageRoute';
}

class LoginPageRouteArgs {
  const LoginPageRouteArgs({this.key, this.title});

  final Key? key;

  final String? title;

  @override
  String toString() {
    return 'LoginPageRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for [SignUpPage]
class SignUpPageRoute extends PageRouteInfo<SignUpPageRouteArgs> {
  SignUpPageRoute({Key? key, String? title})
      : super(name,
            path: '/signup', args: SignUpPageRouteArgs(key: key, title: title));

  static const String name = 'SignUpPageRoute';
}

class SignUpPageRouteArgs {
  const SignUpPageRouteArgs({this.key, this.title});

  final Key? key;

  final String? title;

  @override
  String toString() {
    return 'SignUpPageRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for [JobDetailPage]
class JobDetailPageRoute extends PageRouteInfo<JobDetailPageRouteArgs> {
  JobDetailPageRoute({Key? key, JobOffer? offer})
      : super(name,
            path: '/job-detail-page',
            args: JobDetailPageRouteArgs(key: key, offer: offer));

  static const String name = 'JobDetailPageRoute';
}

class JobDetailPageRouteArgs {
  const JobDetailPageRouteArgs({this.key, this.offer});

  final Key? key;

  final JobOffer? offer;

  @override
  String toString() {
    return 'JobDetailPageRouteArgs{key: $key, offer: $offer}';
  }
}

/// generated route for [HomePage]
class HomePageRoute extends PageRouteInfo<HomePageRouteArgs> {
  HomePageRoute({Key? key, String? title, List<PageRouteInfo>? children})
      : super(name,
            path: '/home',
            args: HomePageRouteArgs(key: key, title: title),
            initialChildren: children);

  static const String name = 'HomePageRoute';
}

class HomePageRouteArgs {
  const HomePageRouteArgs({this.key, this.title});

  final Key? key;

  final String? title;

  @override
  String toString() {
    return 'HomePageRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for [CompleteProfilePage]
class CompleteProfilePageRoute
    extends PageRouteInfo<CompleteProfilePageRouteArgs> {
  CompleteProfilePageRoute(
      {Key? key, String? title, User? userData, dynamic fromSettings})
      : super(name,
            path: '/completeprofile',
            args: CompleteProfilePageRouteArgs(
                key: key,
                title: title,
                userData: userData,
                fromSettings: fromSettings));

  static const String name = 'CompleteProfilePageRoute';
}

class CompleteProfilePageRouteArgs {
  const CompleteProfilePageRouteArgs(
      {this.key, this.title, this.userData, this.fromSettings});

  final Key? key;

  final String? title;

  final User? userData;

  final dynamic fromSettings;

  @override
  String toString() {
    return 'CompleteProfilePageRouteArgs{key: $key, title: $title, userData: $userData, fromSettings: $fromSettings}';
  }
}

/// generated route for [SettingsPage]
class SettingsPageRoute extends PageRouteInfo<void> {
  const SettingsPageRoute() : super(name, path: 'settings');

  static const String name = 'SettingsPageRoute';
}

/// generated route for [ProfilePage]
class ProfilePageRoute extends PageRouteInfo<void> {
  const ProfilePageRoute() : super(name, path: 'profile');

  static const String name = 'ProfilePageRoute';
}

/// generated route for [JobListingPage]
class JobListingPageRoute extends PageRouteInfo<JobListingPageRouteArgs> {
  JobListingPageRoute({Key? key})
      : super(name, path: 'jobhome', args: JobListingPageRouteArgs(key: key));

  static const String name = 'JobListingPageRoute';
}

class JobListingPageRouteArgs {
  const JobListingPageRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'JobListingPageRouteArgs{key: $key}';
  }
}
